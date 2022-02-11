package com.optum.ecp.auth.mapstore;

import com.hazelcast.core.HazelcastInstance;
import com.hazelcast.logging.ILogger;
import com.hazelcast.logging.Logger;
import com.hazelcast.map.MapLoaderLifecycleSupport;
import com.hazelcast.map.MapStore;
import com.optum.ecp.auth.config.ApplicationConfig;
import com.optum.ecp.auth.entity.User;
import com.optum.ecp.auth.repo.UserRepository;
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
public class UserMapStore implements MapStore<String, User>, MapLoaderLifecycleSupport {

    private static final ILogger log = Logger.getLogger(UserMapStore.class);

    private final AnnotationConfigApplicationContext applicationContext = new AnnotationConfigApplicationContext();

    private HazelcastInstance hazelcastInstance;

    private UserRepository userRepository;

    @Override
    public void init(HazelcastInstance hazelcastInstance, Properties properties, String mapName) {
        log.info("UserMapStore::initializing"+properties);
        this.applicationContext.getEnvironment().getPropertySources().addFirst(new PropertiesPropertySource(
                "users", properties));
        this.applicationContext.register(ApplicationConfig.class);
        this.applicationContext.refresh();
        this.userRepository = this.applicationContext.getBean(UserRepository.class);
        this.hazelcastInstance = hazelcastInstance;
        log.info("UserMapStore::initialized");
    }


    @Override
    public void destroy() {
        log.info("UserMapStore::destroying");
        this.applicationContext.close();
        log.info("UserMapStore::destroyed");
    }


    @Override
    public void store(String key, User value) {
        log.info(String.format("UserMapStore::store key %s value %s", key, value));
        this.userRepository.save(value);
    }


    @Override
    public void storeAll(Map<String, User> map) {
        log.info(String.format("UserMapStore::store all %s", map));
        for (Map.Entry<String, User> entry : map.entrySet()) {
            store(entry.getKey(), entry.getValue());
        }
    }


    @Override
    public void delete(String key) {
        log.info(String.format("UserMapStore::delete key %s", key));
        this.userRepository.deleteById(key);
    }


    @Override
    public void deleteAll(Collection<String> keys) {
        log.info(String.format("UserMapStore::delete all %s", keys));
        keys.forEach(this::delete);
    }


    @Override
    public User load(String key) {
        log.info(String.format("UserMapStore::load by key %s", key));
        return this.userRepository.findById(key).orElse(null);
    }


    @Override
    public Map<String, User> loadAll(Collection<String> keys) {
        log.info(String.format("UserMapStore::loadAll by keys %s", keys));
        Map<String, User> result = new LinkedHashMap<>();
        for (String key : keys) {
            User user = load(key);
            if (user != null) {
                result.put(key, user);
            }
        }
        return result;
    }


    @Override
    public Iterable<String> loadAllKeys() {
        log.info("UserMapStore::loadAllKeys");
        return this.userRepository.getAllIds();
    }
}

