package com.wyh.config;

import com.wyh.interceptor.Interceptor;
import com.wyh.interceptor.user_Interceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * @author djz
 * @date 2021/3/19 -8:56
 */
@Configuration
public class InterceptorConfig  implements WebMvcConfigurer {

//    @Override
//    public void addInterceptors(InterceptorRegistry registry) {
//        registry.addInterceptor(new Interceptor()).addPathPatterns("/*");
//        registry.addInterceptor(new user_Interceptor()).addPathPatterns("/*");
//    }
}
