# Spring Boot Package

*[原文](http://eastseven.cn/archives/60)*

### 1. 使用```spring-boot-maven-plugin```打包

- [spring-boot-maven-plugin](http://docs.spring.io/spring-boot/docs/current/maven-plugin/)

```mvn package```

生成一个可执行的```jar```文件

### 2. 自定义打包

由于默认打包方式生成的```jar```文件过于庞大，在带宽受限的网络环境下，部署速度太慢，这时就需要自定义可执行的```jar```文件，只把工程代码打包在```jar```文件中，将依赖文件都存放在其他目录，这样每次生成的```jar```文件体积就非常小，便于传输部署。

最简单的打包方式是使用```maven-jar-plugin```和```maven-dependency-plugin```插件，简单配置一下，即可实现。

```pom.xml```文件配置如下：

```maven
<build>
   <plugins>
       <plugin>
           <groupId>org.springframework.boot</groupId>
           <artifactId>spring-boot-maven-plugin</artifactId>
       </plugin>
       <plugin>
           <groupId>org.apache.maven.plugins</groupId>
           <artifactId>maven-dependency-plugin</artifactId>
       </plugin>
       <plugin>
           <groupId>org.apache.maven.plugins</groupId>
           <artifactId>maven-jar-plugin</artifactId>
           <configuration>
               <!--自定义jar文件名称，可选-->
               <jarName>app</jarName>
               <archive>
                   <manifest>
                       <addClasspath>true</addClasspath>
                       <!--maven-dependency-plugin 默认生成的依赖文件夹名称-->
                       <classpathPrefix>dependency/</classpathPrefix>
                       <mainClass>cn.eastseven.Application</mainClass>
                   </manifest>
               </archive>
           </configuration>
       </plugin>
   </plugins>
</build>
```

执行```mvn clean compile jar:jar dependency:copy-dependencies```命令

```target```目录下

```
target
    |__classes
    |__dependency
    |__generated-source
    |__maven-archiver
    |__maven-status
    |__app.jar
```

其中```app.jar```和```dependency```就是部署时需要的文件

执行```java -jar target/app.jar```即可

PS: *这种打包方式没有分离配置文件。*

[示例源码]()

### 3. 参考
- [Maven生成可以直接运行的jar包的多种方式](http://blog.csdn.net/xiao__gui/article/details/47341385)
- [【SpringBoot】迭代发布下的Jar瘦身实践](http://blog.csdn.net/ssrc0604hx/article/details/54175027)
- [通过Maven构建打包Spring boot，并将config配置文件提取到jar文件外](http://liyunpeng.iteye.com/blog/2321463)

