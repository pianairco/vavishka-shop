package ir.piana.dev.strutser;

import com.hazelcast.config.Config;
import com.hazelcast.config.EvictionPolicy;
import com.hazelcast.config.MapConfig;
import com.hazelcast.config.MaxSizeConfig;
import com.hazelcast.core.Hazelcast;
import com.hazelcast.core.HazelcastInstance;
import com.hazelcast.spring.cache.HazelcastCacheManager;
import org.springframework.cache.CacheManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class SessionConfig {
//    @Bean
//    public Config hazelCastConfig() {
//        return new Config()
//                .setInstanceName("hazelcast-instance")
//                .addMapConfig(
//                        new MapConfig()
//                                .setName("employees")
//                                .setMaxSizeConfig(new MaxSizeConfig(200, MaxSizeConfig.MaxSizePolicy.FREE_HEAP_SIZE))
//                                .setEvictionPolicy(EvictionPolicy.LRU)
//                                .setTimeToLiveSeconds(20));
//    }

    @Bean
    public CacheManager cacheManager() {
        return new HazelcastCacheManager();
    }
}
