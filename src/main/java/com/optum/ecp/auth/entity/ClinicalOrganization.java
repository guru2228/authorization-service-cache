package com.optum.ecp.auth.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Type;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "CLI_ORG")
public class ClinicalOrganization implements Serializable {

    // Note that we are only mapping the fields that we need for the application.

    @Id
    @Column(name = "cli_org_id")
    private String organization;

    @Type(type = "jsonb")
    @Column(name = "cli_desc")
    @Builder.Default
    private Map<String, Object> description = new HashMap<>();

}
