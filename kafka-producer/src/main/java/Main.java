import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.apache.kafka.clients.consumer.ConsumerRecords;
import org.apache.kafka.clients.consumer.KafkaConsumer;
import org.apache.kafka.clients.producer.*;
import org.apache.kafka.common.PartitionInfo;
import org.apache.kafka.common.serialization.StringSerializer;

import java.util.Arrays;
import java.util.List;
import java.util.Properties;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;

/**
 * Created by hcastro on 4/11/16.
 */
public class Main {

    public static void main(String[] args) throws ExecutionException, InterruptedException {
        produce2();
    }

    public static void consume(){
        final String topicName = "myTopic";

        Properties props = new Properties();
        props.put("bootstrap.servers", "172.18.0.5:9092");
        props.put("acks", "all");
        props.put("retries", 0);
        props.put("batch.size", 16384);
        props.put("linger.ms", 1);
        props.put("buffer.memory", 33554432);
        props.put("key.serializer", "org.apache.kafka.common.serialization.StringSerializer");
        props.put("value.serializer", "org.apache.kafka.common.serialization.StringSerializer");
        props.put("key.deserializer", "org.apache.kafka.common.serialization.StringDeserializer");
        props.put("value.deserializer", "org.apache.kafka.common.serialization.StringDeserializer");

        KafkaConsumer<String, String> consumer = new KafkaConsumer<>(props);
        consumer.subscribe(Arrays.asList(topicName));
        try {
            for(int i=0; i<1000; i++) {
                ConsumerRecords<String, String> records = consumer.poll(1000);
                for (ConsumerRecord<String, String> record : records)
                    System.out.println(record.offset() + ": " + record.value());
            }
        } finally {
            consumer.close();
        }
    }

    public static void produce() throws ExecutionException, InterruptedException {
        final String topicName = "myTopic";

        Properties props = new Properties();
        props.put("bootstrap.servers", "172.18.0.5:9092");
        props.put("acks", "all");
        props.put("retries", 0);
        props.put("batch.size", 16384);
        props.put("linger.ms", 1);
        props.put("buffer.memory", 33554432);
        props.put("key.serializer", "org.apache.kafka.common.serialization.StringSerializer");
        props.put("value.serializer", "org.apache.kafka.common.serialization.StringSerializer");

        Producer<String, String> producer = new KafkaProducer<>(props);
        List<PartitionInfo> partitionInfos = producer.partitionsFor(topicName);
        for(PartitionInfo partitionInfo : partitionInfos){
            System.out.println("Partition: " + partitionInfo.toString());
        }
        for(int i = 0; i < 100000; i++) {
            System.out.println("Producing " + i);
            Future<RecordMetadata> send = producer.send(new ProducerRecord<String, String>(topicName, Integer.toString(i), Integer.toString(i)));
            producer.flush();
            System.out.println("Flushed");
            RecordMetadata recordMetadata = send.get();
            System.out.println("Got recordMetadata");
        }

        producer.close();
    }

    public static void produce2() throws ExecutionException, InterruptedException {
        Properties props = new Properties();
        props.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, "172.18.0.5:9092");
        props.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG,StringSerializer.class.getName());
        props.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG,StringSerializer.class.getName());

        KafkaProducer<String,String> producer = new KafkaProducer<String,String>(props);

        boolean sync = false;
        String topic="mytopic3";
        String key = "mykey";
        String value = "myvalue";
        ProducerRecord<String,String> producerRecord = new ProducerRecord<String,String>(topic, key, value);
        if (sync) {
            producer.send(producerRecord).get();
        } else {
            producer.send(producerRecord);
        }
        producer.close();
    }
}
