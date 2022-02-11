package com.optum.ecp.auth.mapstore;

import com.hazelcast.core.HazelcastInstance;
import com.hazelcast.logging.ILogger;
import com.hazelcast.logging.Logger;
import com.hazelcast.map.MapLoaderLifecycleSupport;
import com.hazelcast.map.MapStore;
import com.optum.ecp.auth.config.ApplicationConfig;
import com.optum.ecp.auth.entity.UserRoleKey;
import com.optum.ecp.auth.repo.UserRoleRepository;
import com.optum.ecp.auth.entity.UserRole;
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
public class UserRoleMapStore implements MapStore<UserRoleKey, UserRole>, MapLoaderLifecycleSupport {

    private static final ILogger log = Logger.getLogger(UserSignOnMapStore.class);

    private final AnnotationConfigApplicationContext applicationContext = new AnnotationConfigApplicationContext();

    private HazelcastInstance hazelcastInstance;

    private UserRoleRepository userRoleRepository;

    @Override
    public void init(HazelcastInstance hazelcastInstance, Properties properties, String mapName) {
        log.info("UserRoleMapStore::initializing");
        this.applicationContext.getEnvironment().getPropertySources().addFirst(new PropertiesPropertySource(
                "user-roles", properties));
        this.applicationContext.register(ApplicationConfig.class);
        this.applicationContext.refresh();
        this.userRoleRepository = this.applicationContext.getBean(UserRoleRepository.class);
        this.hazelcastInstance = hazelcastInstance;
        log.info("UserRoleMapStore::initialized");
    }


    @Override
    public void destroy() {
        log.info("UserRoleMapStore::destroying");
        this.applicationContext.close();
        log.info("UserRoleMapStore::destroyed");
    }


    @Override
    public void store(UserRoleKey key, UserRole value) {
        log.info(String.format("UserRoleMapStore::store key %s value %s", key, value));
        this.userRoleRepository.save(value);
    }


    @Override
    public void storeAll(Map<UserRoleKey, UserRole> map) {
        log.info(String.format("UserRoleMapStore::store all %s", map));
        for (Map.Entry<UserRoleKey, UserRole> entry : map.entrySet()) {
            store(entry.getKey(), entry.getValue());
        }
    }


    @Override
    public void delete(UserRoleKey key) {
        log.info(String.format("UserRoleMapStore::delete key %s", key));
        this.userRoleRepository.deleteById(key);
    }


    @Override
    public void deleteAll(Collection<UserRoleKey> keys) {
        log.info(String.format("UserRoleMapStore::delete all %s", keys));
        keys.forEach(this::delete);
    }


    @Override
    public UserRole load(UserRoleKey key) {
        log.info(String.format("UserRoleMapStore::load by key %s", key));
        return this.userRoleRepository.findById(key).orElse(null);
    }


    @Override
    public Map<UserRoleKey, UserRole> loadAll(Collection<UserRoleKey> keys) {
        log.info(String.format("UserRoleMapStore::loadAll by keys %s", keys));
        Map<UserRoleKey, UserRole> result = new LinkedHashMap<>();
        for (UserRoleKey key : keys) {
            UserRole userRole = load(key);
            if (userRole != null) {
                result.put(key, userRole);
            }
        }
        return result;
    }


    @Override
    public Iterable<UserRoleKey> loadAllKeys() {
        log.info("UserRoleMapStore::loadAllKeys");
        return this.userRoleRepository.getAllIds();
    }
}
