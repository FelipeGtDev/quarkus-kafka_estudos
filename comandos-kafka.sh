docker exec -it florinda-eats-kafka-1 kafka-topics.sh --bootstrap-server localhost:9094 --create --partitions 2 --topic pagamentosConfirmados

# Created topic pagamentosConfirmados.

docker exec -it florinda-eats-kafka-1 kafka-topics.sh --bootstrap-server localhost:9094 --describe --topic pagamentosConfirmados

# Topic: pagamentosConfirmados	TopicId: dMu4BDHmTaOOWBoYASo1DQ	PartitionCount: 2	ReplicationFactor: 1	Configs: 
#	Topic: pagamentosConfirmados	Partition: 0	Leader: 0	Replicas: 0	Isr: 0
#	Topic: pagamentosConfirmados	Partition: 1	Leader: 0	Replicas: 0	Isr: 0

docker exec -it florinda-eats-kafka-1 kafka-topics.sh --bootstrap-server localhost:9094 --list

# __consumer_offsets
# pagamentosConfirmados

docker exec -it florinda-eats-kafka-1 kafka-console-producer.sh --bootstrap-server localhost:9094 --topic pagamentosConfirmados --property "parse.key=true" --property "key.separator=;"
# >1;{"pagamentoId": 1, "pedidoId": 1}
# >2;{"pagamentoId":2,"pedidoId":2}
# >

docker exec -it florinda-eats-kafka-1 kafka-console-consumer.sh --bootstrap-server localhost:9094 --topic pagamentosConfirmados --from-beginning --group teste
# {"pagamentoId": 1, "pedidoId": 1}
# {"pagamentoId":2,"pedidoId":2}

docker exec -it florinda-eats-kafka-1 kafka-consumer-groups.sh --bootstrap-server localhost:9094 --all-groups --describe 
# GROUP           TOPIC                 PARTITION  CURRENT-OFFSET  LOG-END-OFFSET  LAG             CONSUMER-ID                                           HOST            CLIENT-ID
# teste           pagamentosConfirmados 0          0               0               0               console-consumer-d6d5e8d1-c9a4-450e-be69-1b719d0c8dba /172.19.0.2     console-consumer
# teste           pagamentosConfirmados 1          2               2               0               console-consumer-d6d5e8d1-c9a4-450e-be69-1b719d0c8dba /172.19.0.2     console-consumer

