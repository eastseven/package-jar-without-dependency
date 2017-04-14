#!/bin/bash

mvn clean compile jar:jar dependency:copy-dependencies

java -jar target/app.jar