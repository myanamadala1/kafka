package com.mbusa.eai.sample.springboot1;

import org.springframework.boot.autoconfigure.security.oauth2.resource.PrincipalExtractor;

import java.util.Map;

public class DaimlerGasPrincipalExtractor implements PrincipalExtractor {
    public DaimlerGasPrincipalExtractor() {
    }

    public Object extractPrincipal(Map<String, Object> map) {
        if (map.containsKey("sub")) {
            return map.get("sub");
        } else {
            return null;
        }
    }
}
