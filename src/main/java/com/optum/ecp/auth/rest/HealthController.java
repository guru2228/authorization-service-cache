package com.optum.ecp.auth.rest;


import com.hazelcast.cluster.ClusterState;
import com.hazelcast.core.HazelcastInstance;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;


/*
 * @author gsithura
 * created on 1/18/22
 */
@Slf4j
@RestController
public class HealthController {

    @Autowired
    private HazelcastInstance hazelcastInstance;

    /**
     * @return {@code true} if good, exception otherwise
     */
    @GetMapping("/healthz")
    public String healthz() {
        log.info("healthz()");

        ClusterState clusterState = this.hazelcastInstance.getCluster().getClusterState();

        if (clusterState == ClusterState.ACTIVE) {
            return Boolean.TRUE.toString();
        } else {
            throw new RuntimeException("ClusterState==" + clusterState);
        }
    }
}
