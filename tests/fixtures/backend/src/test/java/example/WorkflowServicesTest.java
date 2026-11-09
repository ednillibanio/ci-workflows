package example;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.sql.DriverManager;
import java.util.Map;
import org.junit.jupiter.api.Test;
import redis.clients.jedis.Jedis;

class WorkflowServicesTest {
  private static final Map<String, String> ENV = System.getenv();

  @Test
  void connectsToPostgresService() throws Exception {
    var url = ENV.getOrDefault("TEST_POSTGRES_URL", "jdbc:postgresql://localhost:5432/saplnext_test");
    var user = ENV.getOrDefault("TEST_POSTGRES_USER", "sapl");
    var password = ENV.getOrDefault("TEST_POSTGRES_PASSWORD", "sapl");
    try (var connection = DriverManager.getConnection(url, user, password)) {
      assertEquals("saplnext_test", connection.getCatalog());
    }
  }

  @Test
  void connectsToRedisService() {
    var port = Integer.parseInt(ENV.getOrDefault("TEST_REDIS_PORT", "6379"));
    try (var redis = new Jedis("localhost", port)) {
      assertEquals("PONG", redis.ping());
    }
  }
}
