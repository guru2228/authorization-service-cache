package com.optum.ecp.auth.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Formula;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "USER_CLI_FUNC_ROLE")
@IdClass(UserRoleKey.class)
@SuppressWarnings("serial")
public class UserRole implements Serializable {

    // Note that we are only mapping the fields that we need for the application.
    // Many of the fields on this table are nullable and are not needed for our purposes.

    @Id
    @Column(name = "user_id")
    private String userId;

    @Id
    @Column(name = "cli_org_id")
    private String organization;

    @Id
    @Column(name = "func_role_nm")
    private String roleName;

    @Column(name = "strt_dt")
    private Date startDate;

    @Column(name = "end_dt")
    private Date endDate;

    @Column(name = "sgnon_dflt_ind")
    private Integer sgnonDfltInd;

    @Formula("strt_dt <= CURRENT_DATE AND (end_dt IS NULL OR end_dt >= CURRENT_DATE)")
    private boolean active;


}
