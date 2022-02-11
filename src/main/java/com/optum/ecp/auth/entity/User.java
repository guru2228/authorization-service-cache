package com.optum.ecp.auth.entity;

import com.vladmihalcea.hibernate.type.json.JsonBinaryType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Type;
import org.hibernate.annotations.TypeDef;
import org.hibernate.annotations.TypeDefs;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "USER_TBL")
@TypeDefs(@TypeDef(name = "jsonb", typeClass = JsonBinaryType.class))
@EntityListeners(AuditingEntityListener.class)
public class User implements Serializable {

  // Note that we are only mapping the fields that we need for the application.
  // Many of the fields on this table are nullable and are not needed for our purposes.

    @Id
    @Column(name = "user_id")
    private String userId;

    @Column(name = "alt_user_id")
    private String alternateUserId;

    @Column(name = "idp_typ_ref_id")
    private Integer identityProviderCode;

    @Version  // Spring JPA will auto-update this field
    @Column(name = "updt_ver_nbr")
    private Integer version;

    @Column(name = "user_sts_ref_id")
    private Integer userStatusCode;

    @Column(name = "lst_nm")
    private String lastName;

    @Column(name = "fst_nm")
    private String firstName;

    @Column(name = "email_id")
    private String email;

    @CreatedDate
    @Column(name = "creat_dttm")
    private Date createDate;

    @LastModifiedDate
    @Column(name = "chg_dttm")
    private Date changeDate;

    @Type(type = "jsonb")
    @Column(name = "user_atr_list")
    @Builder.Default
    private Map<String, Object> attributes = new HashMap<>();  // it's not nullable, so default to empty object

}
