package com.homecare.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.domain.AuditorAware;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.Optional;

/**
 * Enables Spring Data JPA auditing.
 * Provides the current user id for createdBy / updatedBy fields.
 *
 * Until Phase 2 (Spring Security with JWT) is in place, this will return empty
 * because there is no authenticated user. That is fine — those columns are nullable.
 */
@Configuration
public class JpaAuditingConfig {

    @Bean
    public AuditorAware<Long> auditorProvider() {
        return () -> {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            if (auth == null
                    || !auth.isAuthenticated()
                    || "anonymousUser".equals(auth.getPrincipal())) {
                return Optional.empty();
            }
            try {
                return Optional.of(Long.parseLong(auth.getName()));
            } catch (NumberFormatException e) {
                return Optional.empty();
            }
        };
    }
}