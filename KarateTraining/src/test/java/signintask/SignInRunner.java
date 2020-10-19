package signintask;

import com.intuit.karate.junit5.Karate;

public class SignInRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run().relativeTo(getClass());
    }
}
