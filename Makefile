WORKDIR=$(PWD)/autotools_osx.build
OUTDIR=$(PWD)
AUTOMAKE_VERSION=1.12
AUTOCONF_VERSION=2.68

all: autoconf automake
	@echo ""
	@echo ""
	@echo Cut and paste the following line to your shell to setup tools.
	@echo ""
	@echo 'PATH=$$PATH:$$PWD/bin /bin/sh'
	@echo ""
	@echo ""

autoconf: $(OUTDIR)/bin/autoconf

$(OUTDIR)/bin/autoconf: $(WORKDIR)/autoconf-$(AUTOCONF_VERSION)/Makefile
	cd $(dir $^) && make install

$(WORKDIR)/autoconf-$(AUTOCONF_VERSION)/Makefile: $(WORKDIR)/autoconf-$(AUTOCONF_VERSION)/configure.ac
	cd $(dir $@) && ./configure --prefix=$(OUTDIR)

$(WORKDIR)/autoconf-$(AUTOCONF_VERSION)/configure.ac: $(WORKDIR)/autoconf-$(AUTOCONF_VERSION).tar.gz
	cd $(WORKDIR) && tar zxvf $(notdir $^)
	touch $@

$(WORKDIR)/autoconf-$(AUTOCONF_VERSION).tar.gz:
	mkdir -p $(dir $@)
	cd $(dir $@) && curl -O https://ftp.gnu.org/gnu/autoconf/autoconf-$(AUTOCONF_VERSION).tar.gz

automake: $(OUTDIR)/bin/automake

$(OUTDIR)/bin/automake: $(WORKDIR)/automake-$(AUTOMAKE_VERSION)/Makefile
	cd $(dir $^) && PATH=$(PATH):$(OUTDIR)/bin make install

$(WORKDIR)/automake-$(AUTOMAKE_VERSION)/Makefile: $(WORKDIR)/automake-$(AUTOMAKE_VERSION)/configure $(OUTDIR)/bin/autoconf
	cd $(dir $@) && PATH=$(PATH):$(OUTDIR)/bin ./configure --prefix=$(OUTDIR)

$(WORKDIR)/automake-$(AUTOMAKE_VERSION)/configure: $(WORKDIR)/automake-$(AUTOMAKE_VERSION).tar.gz
	cd $(WORKDIR) && tar zxvf $(notdir $^)
	touch $@

$(WORKDIR)/automake-$(AUTOMAKE_VERSION).tar.gz:
	mkdir -p $(dir $@)
	cd $(dir $@) && curl -O https://ftp.gnu.org/gnu/automake/automake-$(AUTOMAKE_VERSION).tar.gz

