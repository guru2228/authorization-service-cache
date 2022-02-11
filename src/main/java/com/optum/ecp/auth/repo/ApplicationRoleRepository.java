package com.optum.ecp.auth.repo;

import com.optum.ecp.auth.entity.ApplicationRole;
import com.optum.ecp.auth.entity.ApplicationRoleKey;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface ApplicationRoleRepository extends JpaRepository<ApplicationRole, ApplicationRoleKey> {

    @Query("SELECT new com.optum.ecp.auth.entity.ApplicationRoleKey(a.applicationName,a.organization,a.roleName) FROM ApplicationRole a")
    Iterable<ApplicationRoleKey> getAllIds();
}
