FROM resin/rpi-raspbian

# define variables
ENV GOOGLE_AUTHENTICATOR_VERSION=1.05 \
  OTPSPOT_VERSION=2.0

# Install required packages with apt
RUN apt-get update \
  && apt-get install -y \
  build-essential \
  autoconf \
  automake \
  libtool \
  libpam0g-dev \
  libqrencode3 \
  pamtester \
  python-flask

# install google-authenticator-libpam
RUN curl -L https://github.com/google/google-authenticator-libpam/archive/$GOOGLE_AUTHENTICATOR_VERSION.tar.gz > $GOOGLE_AUTHENTICATOR_VERSION.tar.gz \
  && tar zxfv $GOOGLE_AUTHENTICATOR_VERSION.tar.gz \
  && rm -f $GOOGLE_AUTHENTICATOR_VERSION.tar.gz \
  && cd google-authenticator-libpam-$GOOGLE_AUTHENTICATOR_VERSION \
  && ./bootstrap.sh \
  && ./configure \
  && make \
  && make install \
  && make clean \
  && mkdir -p /lib/security \
  && mv /usr/local/lib/security/* /lib/security

# install otpspot
RUN curl -L https://github.com/user2684/otpspot/archive/v$OTPSPOT_VERSION.tar.gz > $OTPSPOT_VERSION.tar.gz \
  && tar zxfv $OTPSPOT_VERSION.tar.gz \
  && rm -f $OTPSPOT_VERSION.tar.gz \
  && mv otpspot-$OTPSPOT_VERSION otpspot \
  && mv otpspot/template_pam /etc/pam.d/otpspot

# Expose network services
EXPOSE 8000

# Expose Volumes
VOLUME /conf

# Install entrypoint
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["bash","/docker-entrypoint.sh"]

# Start otpspot
CMD ["otpspot"]
