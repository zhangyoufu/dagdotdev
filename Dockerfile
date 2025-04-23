FROM --platform=$BUILDPLATFORM docker.io/library/golang:1-alpine AS build
ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT
RUN --mount=type=bind,target=/mnt mkdir /dist && /mnt/build.sh -o /dist/oci && cp -r /mnt/cmd/oci/kodata /dist/

FROM scratch
COPY --link --from=build /dist /
ENTRYPOINT ["/oci"]
ENV PORT=8080
ENV USERAGENT=dagdotdev
ENV KO_DATA_PATH=/kodata
