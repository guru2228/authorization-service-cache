package com.optum.ecp.auth.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;

import java.io.Serializable;

/*
 * @author gsithura
 * created on 1/19/22
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserRoleKey implements Serializable {

    private String userId;
    private String organization;
    private String roleName;

    @Override
    public boolean equals(Object o) {
        return EqualsBuilder.reflectionEquals(this, o, false);
    }

    @Override
    public int hashCode() {
        return HashCodeBuilder.reflectionHashCode(this, false);
    }
}
