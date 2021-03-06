###################################################################################
# Copyright (C) 1999-2020  Gentoo Authors                                         #
#                                                                                 #
# This program is free software; you can redistribute it and/or                   #
# modify it under the terms of the GNU General Public License                     #
# as published by the Free Software Foundation; either version 2                  #
# of the License, or (at your option) any later version.                          #
#                                                                                 #
# This program is distributed in the hope that it will be useful,                 #
# but WITHOUT ANY WARRANTY; without even the implied warranty of                  #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                   #
# GNU General Public License for more details.                                    #
#                                                                                 #
# You should have received a copy of the GNU General Public License               #
# along with this program; if not, write to the Free Software                     #
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA. #
###################################################################################
#
# source: https://forums.gentoo.org/viewtopic-t-1092792-postdays-0-postorder-asc-start-75.html#8478520

EAPI="7"

inherit git-r3 toolchain-funcs

DESCRIPTION="suid program that helps to implement a workaround for using modesetting driver under rootless xorg"
HOMEPAGE="https://github.com/gch1p/drm_master_util https://ch1p.io/non-root-xorg-modesetting/"
EGIT_REPO_URI="https://github.com/gch1p/drm_master_util.git"
EGIT_BRANCH="master"
EGIT_COMMIT="e9412bbc8df43ee3282ae515198b39ae7c99f09d"

LICENSE="MIT"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND="x11-libs/libdrm"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

src_compile()
{
   tc-export PKG_CONFIG
   local LIBDRM_CFLAGS="$(${PKG_CONFIG} --cflags libdrm)"
   local LIBDRM_LIBS="$(${PKG_CONFIG} --libs libdrm)"
   $(tc-getCC) -o ${PN} ${CPPFLAGS} ${LIBDRM_CFLAGS} ${CFLAGS} \
      ${LDFLAGS} drm_master_util.c ${LIBDRM_LIBS} ||
      die "Could not compile ${PN}"
}

src_install()
{
   dobin "${S}/${PN}"
   fperms 4711 /usr/bin/${PN}
}
