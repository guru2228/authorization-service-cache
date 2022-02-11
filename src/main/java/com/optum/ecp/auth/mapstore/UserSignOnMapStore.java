package com.optum.ecp.auth.mapstore;

import com.hazelcast.core.HazelcastInstance;
import com.hazelcast.logging.ILogger;
import com.hazelcast.logging.Logger;
import com.hazelcast.map.MapLoaderLifecycleSupport;
import com.hazelcast.map.MapStore;
import com.optum.ecp.auth.config.ApplicationConfig;
import com.optum.ecp.auth.entity.UserSignOn;
import com.optum.ecp.auth.repo.UserSignonRepository;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.core.env.PropertiesPropertySource;

import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Properties;

/*
 * @author gsithura
 * created on 1/17/22
 */

public class UserSignOnMapStore implements MapStore<String, UserSignOn>, MapLoaderLifecycleSupport {

    private static final ILogger log = Logger.getLogger(UserSignOnMapStore.class);

    private final AnnotationConfigApplicationContext applicationContext = new AnnotationConfigApplicationContext();

    private HazelcastInstance hazelcastInstance;

    private UserSignonRepository userSignonRepository;

    @Override
    public void init(HazelcastInstance hazelcastInstance, Properties properties, String mapName) {
        log.info("UserSignOnMapStore::initializing");
        this.applicationContext.getEnvironment().getPropertySources().addFirst(new PropertiesPropertySource(
                "user-sign-on", properties));
        this.applicationContext.register(ApplicationConfig.class);
        this.applicationContext.refresh();
        this.userSignonRepository = this.applicationContext.getBean(UserSignonRepository.class);
        this.hazelcastInstance = hazelcastInstance;
        log.info("UserSignOnMapStore::initialized");
    }


    @Override
    public void destroy() {
        log.info("UserSignOnMapStore::destroying");
        this.applicationContext.close();
        log.info("UserSignOnMapStore::destroyed");
    }


    @Override
    public void store(String key, UserSignOn value) {
        log.info(String.format("UserSignOnMapStore::store key %s value %s", key, value));
        this.userSignonRepository.trackUserLogin(key);
    }


    @Override
    public void storeAll(Map<String, UserSignOn> map) {
        log.info(String.format("UserSignOnMapStore::store all %s", map));
        for (Map.Entry<String, UserSignOn> entry : map.entrySet()) {
            store(entry.getKey(), entry.getValue());
        }
    }


    @Override
    public void delete(String key) {
        log.info(String.format("UserSignOnMapStore::delete key %s", key));
        this.userSignonRepository.deleteById(key);
    }


    @Override
    public void deleteAll(Collection<String> keys) {
        log.info(String.format("UserSignOnMapStore::delete all %s", keys));
        keys.forEach(this::delete);
    }


    @Override
    public UserSignOn load(String key) {
        log.info(String.format("UserSignOnMapStore::load by key %s", key));
        return this.userSignonRepository.findById(key).orElse(null);
    }


    @Override
    public Map<String, UserSignOn> loadAll(Collection<String> keys) {
        log.info(String.format("UserSignOnMapStore::loadAll by keys %s", keys));
        Map<String, UserSignOn> result = new LinkedHashMap<>();
        for (String key : keys) {
            UserSignOn userSignOn = load(key);
            if (userSignOn != null) {
                result.put(key, userSignOn);
            }
        }
        return result;
    }


    @Override
    public Iterable<String> loadAllKeys() {
        log.info("UserSignOnMapStore::loadAllKeys");
        return this.userSignonRepository.getAllIds();
    }
}
