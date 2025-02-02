# Copyright 2017-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick-0.7.18
	ansi_term-0.12.1
	anyhow-1.0.56
	assert_cmd-2.0.4
	atty-0.2.14
	bitflags-1.3.2
	bstr-0.2.17
	cc-1.0.73
	cfg-if-1.0.0
	clap-2.34.0
	crossbeam-channel-0.5.4
	crossbeam-utils-0.8.8
	difflib-0.4.0
	doc-comment-0.3.3
	either-1.6.1
	env_logger-0.9.0
	errno-0.2.8
	errno-dragonfly-0.1.2
	escargot-0.5.7
	hermit-abi-0.1.19
	itertools-0.10.3
	itoa-1.0.1
	kernel32-sys-0.2.2
	lazy_static-1.4.0
	libc-0.2.123
	log-0.4.16
	memchr-2.4.1
	num_threads-0.1.5
	once_cell-1.10.0
	predicates-2.1.1
	predicates-core-1.0.3
	predicates-tree-1.0.5
	proc-macro2-1.0.37
	quote-1.0.18
	regex-1.5.5
	regex-automata-0.1.10
	regex-syntax-0.6.25
	ryu-1.0.9
	serde-1.0.136
	serde_derive-1.0.136
	serde_json-1.0.79
	strsim-0.8.0
	syn-1.0.91
	sysconf-0.3.4
	termcolor-1.1.3
	termtree-0.2.4
	textwrap-0.11.0
	time-0.3.9
	time-macros-0.2.4
	unicode-width-0.1.9
	unicode-xid-0.2.2
	vec_map-0.8.2
	wait-timeout-0.2.0
	winapi-0.2.8
	winapi-0.3.9
	winapi-build-0.1.1
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
"

inherit cargo shell-completion

DESCRIPTION="A fast, accurate, ergonomic emerge.log parser"
HOMEPAGE="https://github.com/vincentdephily/emlop"
SRC_URI="
	https://github.com/vincentdephily/emlop/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris ${CRATES})
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="bash-completion zsh-completion fish-completion"
RESTRICT="mirror"

QA_FLAGS_IGNORED="usr/bin/emlop"

src_install() {
	cargo_src_install
	einstalldocs
	if use bash-completion; then
		./target/$(usex debug debug release)/emlop complete bash > "${PN}"
		dobashcomp emlop
	fi
	if use zsh-completion; then
		./target/$(usex debug debug release)/emlop complete zsh > "_${PN}"
		dozshcomp "_${PN}"
	fi
	if use fish-completion; then
		./target/$(usex debug debug release)/emlop complete fish > "${PN}.fish"
		dofishcomp "${PN}.fish"
	fi
}
