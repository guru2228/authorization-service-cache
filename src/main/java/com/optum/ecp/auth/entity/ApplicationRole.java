package com.optum.ecp.auth.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Formula;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "CLI_FUNC_ROLE_APPL")
@IdClass(ApplicationRoleKey.class)
@SuppressWarnings("serial")
public class ApplicationRole implements Serializable {

    // Note that we are only mapping the fields that we need for the application.
    // Many of the fields on this table are nullable and are not needed for our purposes.

    @Id
    @Column(name = "appl_nm")
    private String applicationName;

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

    @Formula("strt_dt <= CURRENT_DATE AND (end_dt IS NULL OR end_dt >= CURRENT_DATE)")
    private boolean active;

    @Column(name = "prmis_role_nm")
    private String permission;
    
    @Type(type = "jsonb")
    @Column(name = "cstm_prmis_role_list", columnDefinition = "jsonb")
    private  String customPermissionRoleList;


}
