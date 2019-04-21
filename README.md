Kafka
=============
Configuration for a Kafka cluster within the OCF Kubernetes cluster. It uses the Zookeeper cluster that's also run within the Kubernetes cluster.

You can connect to the brokers in the cluster from applications within Kubernetes using the following broker list:

```
kafka-0.kafka-svc.app-kafka.svc.cluster.local:9092
kafka-1.kafka-svc.app-kafka.svc.cluster.local:9092
kafka-2.kafka-svc.app-kafka.svc.cluster.local:9092
```
