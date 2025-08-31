FROM openjdk:11-jre-slim

ENV FDT_VERSION=0.26.3
ENV FDT_HOME=/fdt
ENV FDT_JAR=${FDT_HOME}/fdt.jar

RUN mkdir -p ${FDT_HOME} \
    && curl -L https://github.com/fast-data-transfer/fdt/releases/download/${FDT_VERSION}/fdt.jar -o ${FDT_JAR}
# Expose the FDT default port
EXPOSE 54321

WORKDIR ${FDT_HOME}

# Command to run FDT
CMD ["java", "-jar", "fdt.jar", "-p", "54321"]
