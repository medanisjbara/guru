# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_7 )

inherit distutils-r1

SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.zip"
#26 failed tests
RESTRICT="test"
KEYWORDS="~amd64"

DESCRIPTION="A bridge from UFOs to FontTool objects"
HOMEPAGE="https://github.com/googlefonts/ufo2ft"

LICENSE="MIT"
SLOT="0"

PATCHES=( "${FILESDIR}/${PN}-exportedglyphs.diff" )

RDEPEND="
	>=dev-python/booleanOperations-0.9.0[${PYTHON_USEDEP}]
	>=dev-python/compreffor-0.4.6[${PYTHON_USEDEP}]
	>=dev-python/cu2qu-1.6.6[${PYTHON_USEDEP}]
	dev-python/defcon[${PYTHON_USEDEP}]
	>=dev-python/fonttools-4.4.0[${PYTHON_USEDEP}]
	>=dev-python/skia-pathops-0.2.0[${PYTHON_USEDEP}]
	>=dev-python/ufoLib2-0.5.1[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		dev-python/glyphsLib[${PYTHON_USEDEP}]
	)
"
BDEPEND="
	app-arch/unzip
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
