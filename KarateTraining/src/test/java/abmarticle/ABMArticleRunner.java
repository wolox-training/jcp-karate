package abmarticle;

import com.intuit.karate.junit5.Karate;

public class ABMArticleRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("classpath:java/abmarticle").relativeTo(getClass());
    }
}
