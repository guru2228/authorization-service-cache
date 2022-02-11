package com.optum.ecp.auth.mapstore;

import com.hazelcast.core.HazelcastInstance;
import com.hazelcast.logging.ILogger;
import com.hazelcast.logging.Logger;
import com.hazelcast.map.MapLoaderLifecycleSupport;
import com.hazelcast.map.MapStore;
import com.optum.ecp.auth.config.ApplicationConfig;
import com.optum.ecp.auth.entity.ApplicationRole;
import com.optum.ecp.auth.entity.ApplicationRoleKey;
import com.optum.ecp.auth.entity.User;
import com.optum.ecp.auth.repo.ApplicationRoleRepository;
import com.optum.ecp.auth.repo.UserRepository;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.core.env.PropertiesPropertySource;

import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Properties;

/*
 * @author gsithura
 * created on 1/31/22
 */
public class ApplicationRoleMapStore implements MapStore<ApplicationRoleKey, ApplicationRole>, MapLoaderLifecycleSupport {

    private static final ILogger log = Logger.getLogger(UserMapStore.class);

    private final AnnotationConfigApplicationContext applicationContext = new AnnotationConfigApplicationContext();

    private HazelcastInstance hazelcastInstance;

    private ApplicationRoleRepository applicationRoleRepository;

    @Override
    public void init(HazelcastInstance hazelcastInstance, Properties properties, String mapName) {
        log.info("UserMapStore::initializing"+properties);
        this.applicationContext.getEnvironment().getPropertySources().addFirst(new PropertiesPropertySource(
                "users", properties));
        this.applicationContext.register(ApplicationConfig.class);
        this.applicationContext.refresh();
        this.applicationRoleRepository = this.applicationContext.getBean(ApplicationRoleRepository.class);
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
    public void store(ApplicationRoleKey key, ApplicationRole value) {
        log.info(String.format("UserMapStore::store key %s value %s", key, value));
        this.applicationRoleRepository.save(value);
    }


    @Override
    public void storeAll(Map<ApplicationRoleKey, ApplicationRole> map) {
        log.info(String.format("UserMapStore::store all %s", map));
        for (Map.Entry<ApplicationRoleKey, ApplicationRole> entry : map.entrySet()) {
            store(entry.getKey(), entry.getValue());
        }
    }


    @Override
    public void delete(ApplicationRoleKey key) {
        log.info(String.format("UserMapStore::delete key %s", key));
        this.applicationRoleRepository.deleteById(key);
    }


    @Override
    public void deleteAll(Collection<ApplicationRoleKey> keys) {
        log.info(String.format("UserMapStore::delete all %s", keys));
        keys.forEach(this::delete);
    }


    @Override
    public ApplicationRole load(ApplicationRoleKey key) {
        log.info(String.format("UserMapStore::load by key %s", key));
        return this.applicationRoleRepository.findById(key).orElse(null);
    }


    @Override
    public Map<ApplicationRoleKey, ApplicationRole> loadAll(Collection<ApplicationRoleKey> keys) {
        log.info(String.format("UserMapStore::loadAll by keys %s", keys));
        Map<ApplicationRoleKey, ApplicationRole> result = new LinkedHashMap<>();
        for (ApplicationRoleKey key : keys) {
            ApplicationRole applicationRole = load(key);
            if (applicationRole != null) {
                result.put(key, applicationRole);
            }
        }
        return result;
    }


    @Override
    public Iterable<ApplicationRoleKey> loadAllKeys() {
        log.info("UserMapStore::loadAllKeys");
        return this.applicationRoleRepository.getAllIds();
    }
}
