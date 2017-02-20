require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcs < AbstractPhp70Extension
  init
  desc "PCS provides a way to mix C and PHP code in your PHP extension."
  homepage "https://github.com/flaupretre/pecl-pcs"
  url "https://pecl.php.net/get/pcs-1.3.3.tgz"
  sha256 "b77859a06ff361a51846cc3f5939703e8322beeb1f0383766c7f3e44ef0b9734"
  head "https://github.com/flaupretre/pecl-pcs.git"

  def install
    Dir.chdir "pcs-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    args = []
    args << "--prefix=#{prefix}"
    args << phpconfig

    safe_phpize

    system "./configure", *args
    system "make"
    prefix.install "modules/pcs.so"
    write_config_file if build.with? "config-file"
  end
end
