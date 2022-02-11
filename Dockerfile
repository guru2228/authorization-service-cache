FROM hazelcast/hazelcast-enterprise:5.0.2
COPY target/authorization-service-cache-*.jar ${HZ_HOME}

