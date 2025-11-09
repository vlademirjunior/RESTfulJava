package br.com.restfuljava.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class OpenApiConfig {

    @Bean
    OpenAPI customOpenAPI(){
        return new OpenAPI()
            .info(new Info()
                .title("RESTful API's")
                    .version("v1")
                    .description("REST API's RESTful using Java, Spring Boot, and Docker")
                    .termsOfService("https://vlademir.dev")
                    .license(new License()
                        .name("Apache 2.0")
                        .url("https://vlademir.dev")
                    )
            );
    }
}
