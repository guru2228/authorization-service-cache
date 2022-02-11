package com.optum.ecp.auth.repo;

import com.optum.ecp.auth.entity.UserSignOn;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface UserSignonRepository extends JpaRepository<UserSignOn, String> {

    @Query("SELECT u.userId FROM UserSignOn u")
    Iterable<String> getAllIds();

    /** Track the most recent login for a user. */
    @Modifying(flushAutomatically = true, clearAutomatically = true)
    @Query(nativeQuery = true,
            value = "INSERT INTO USER_SGNON (user_id, lst_sgnon_dttm, lst_sgnoff_dttm) VALUES (?1, CURRENT_TIMESTAMP, NULL) " +
                    "       ON CONFLICT (user_id) DO UPDATE SET lst_sgnon_dttm = CURRENT_TIMESTAMP, lst_sgnoff_dttm = NULL")
    void trackUserLogin(String userId);
}
