## How to generate smaller docker images

Using `Jdeps` and `Jlink` to build JRE image only with necessary dependencies.

### Result:
```
bproenca/jre-temurin-slim	79.9MB
bproenca/jre-temurin-fat	354MB
```

> Jdeps is responsible for analysing a JAR, with its dependencies, and identifying the parts of the JVM needed to run the application. It can output this to a text file, which can then be consumed by jlink.

> Jlink takes a list of JVM modules, and builds a custom JVM with only those parts present. Depending on your application, this can obviously cut out massive parts of the runtime, reducing your overall Docker image size.


Test:
```
./build.sh
./run.sh
```

See also:  
* https://levelup.gitconnected.com/java-developing-smaller-docker-images-with-jdeps-and-jlink-d4278718c550