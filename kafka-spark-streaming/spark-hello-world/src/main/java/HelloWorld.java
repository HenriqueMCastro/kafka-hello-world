import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaSparkContext;
import org.apache.spark.api.java.function.FlatMapFunction;
import org.apache.spark.api.java.function.Function;
import org.apache.spark.api.java.function.Function2;
import org.apache.spark.api.java.function.PairFunction;
import org.apache.spark.streaming.Seconds;
import org.apache.spark.streaming.api.java.JavaDStream;
import org.apache.spark.streaming.api.java.JavaPairDStream;
import org.apache.spark.streaming.api.java.JavaPairReceiverInputDStream;
import org.apache.spark.streaming.api.java.JavaStreamingContext;
import org.apache.spark.streaming.kafka.KafkaUtils;
import scala.Tuple2;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

/**
 * Created by hcastro on 4/14/16.
 */
public class HelloWorld {

    private static final String ZK_QUORUM = "zookeeper-node-1:2181,zookeeper-node-2:2181,zookeeper-node-3:2181";

    private static final String GROUP = "0";

    private static final Pattern SPACE = Pattern.compile(" ");

    public static void main(String[] args) {
        SparkConf sparkConf = new SparkConf().setAppName("HelloWorld");
        JavaSparkContext ctx = new JavaSparkContext(sparkConf);
        JavaStreamingContext streamingContext = new JavaStreamingContext(ctx, Seconds.apply(10));

        Map<String, String> kafkaConfig = new HashMap<String, String>();
        kafkaConfig.put("metadata.broker.list", "kafka-node-1:9092");
        kafkaConfig.put("zookeeper.connect", "zookeeper-node-1:2181,zookeeper-node-2:2181,zookeeper-node-3:2181");

        int numberOfThreads = 1;
        Map<String, Integer> topicMap = new HashMap<String, Integer>();
        topicMap.put("raw", numberOfThreads);

        JavaPairReceiverInputDStream<String, String> kafkaStream = KafkaUtils.createStream(
                streamingContext, ZK_QUORUM, GROUP, topicMap);

        JavaDStream<String> lines = kafkaStream.map(new Function<Tuple2<String, String>, String>() {
            public String call(Tuple2<String, String> tuple2) {
                return tuple2._2();
            }
        });

        JavaDStream<String> words = lines.flatMap(new FlatMapFunction<String, String>() {
            public Iterable<String> call(String s) throws Exception {
                return Arrays.asList(SPACE.split(s));
            }
        });

        JavaPairDStream<String, Integer> wordCounts = words.mapToPair(
                new PairFunction<String, String, Integer>() {
                    public Tuple2<String, Integer> call(String s) {
                        return new Tuple2<String, Integer>(s, 1);
                    }
                }).reduceByKey(new Function2<Integer, Integer, Integer>() {
            public Integer call(Integer i1, Integer i2) {
                return i1 + i2;
            }
        });

        wordCounts.print();
        streamingContext.start();
        streamingContext.awaitTermination();
    }
}
