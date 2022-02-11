package com.optum.ecp.auth.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "USER_SGNON")
public class UserSignOn implements Serializable {

    // Note that we are only mapping the fields that we need for the application.
    // Many of the fields on this table are nullable and we have no source for the data.

    @Id
    @Column(name = "user_id")
    private String userId;

    @Column(name = "lst_sgnon_dttm")
    private Date signonDate;

    @Column(name = "lst_sgnoff_dttm")
    private Date signoffDate;
}
