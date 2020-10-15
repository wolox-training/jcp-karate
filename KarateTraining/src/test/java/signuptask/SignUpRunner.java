package signuptask;

import com.intuit.karate.junit5.Karate;

public class SignUpRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("signup").relativeTo(getClass());
    }
}
