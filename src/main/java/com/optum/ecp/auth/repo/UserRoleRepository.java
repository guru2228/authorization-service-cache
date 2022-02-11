package com.optum.ecp.auth.repo;

import com.optum.ecp.auth.entity.UserRole;
import com.optum.ecp.auth.entity.UserRoleKey;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;

@Repository
@Transactional
public interface UserRoleRepository extends JpaRepository<UserRole, UserRoleKey> {

    @Query("SELECT new com.optum.ecp.auth.entity.UserRoleKey(u.userId, u.organization, u.roleName) FROM UserRole u")
    Iterable<UserRoleKey> getAllIds();
}
