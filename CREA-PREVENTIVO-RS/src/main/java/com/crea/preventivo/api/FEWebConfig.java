package com.crea.preventivo.api;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class FEWebConfig implements WebMvcConfigurer {

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/generate-pdf")
                .allowedOrigins("http://localhost:4200")
                .allowedMethods("POST")
                .allowedHeaders("Authorization", "Content-Type")
                .exposedHeaders("Content-Disposition")
                .maxAge(3600);
    }
}
