Name: gdsl
Summary: Generic Data Structures Library (GDSL)
Packager: Torsten Luettgert <t.luettgert@combox.de> & Nicolas Darnis <ndarnis@free.fr>
%define version     1.8
Version: %{version}
%define release     0
Release: %{release}
License: GPL
Vendor: The GDSL Team
Url: http://www.nongnu.org/%{name}/
#Copyright: Copyright (C) 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012 The GDSL Team
Source: http://savannah.nongnu.org/download/gdsl/%{version}/%{name}-%{version}.tar.gz
Group: Development/Libraries
%define mybuildroot /var/tmp/%{name}-build
BuildRoot: %{mybuildroot}
%define _prefix     /home/hellowork/mywork/n1/server/trunk2/skynet/3rd/gdsl
%define _mandir     %{_prefix}/man

%description
The Generic Data Structures Library (GDSL) is a collection of routines for generic data structures manipulation. It is a portable and re-entrant library fully written from scratch in pure ANSI C. It is designed to offer for C programmers common data structures with powerful algorithms, and hidden implementation. Available structures are lists, queues, stacks, hash-tables, binary trees, search binary trees, red-black trees, 2D arrays, permutations, heaps and interval heaps.

%prep
%setup -q -n %{name}-%{version}

%build
CFLAGS="$RPM_OPT_FLAGS"
./configure \
    --prefix=%{_prefix} \
    --bindir=%{_bindir} \
    --mandir=%{_mandir} \
    --localstatedir=%{_localstatedir} \
    --libdir=%{_libdir} \
    --datadir=%{_datadir} \
    --includedir=%{_includedir} \
    --sysconfdir=%{_sysconfdir}
make

%install
rm -rf $RPM_BUILD_ROOT

make prefix=$RPM_BUILD_ROOT%{_prefix} bindir=$RPM_BUILD_ROOT%{_bindir} \
    mandir=$RPM_BUILD_ROOT%{_mandir} libdir=$RPM_BUILD_ROOT%{_libdir} \
    localstatedir=$RPM_BUILD_ROOT%{_localstatedir} \
    datadir=$RPM_BUILD_ROOT%{_datadir} \
    includedir=$RPM_BUILD_ROOT%{_includedir} \
    sysconfdir=$RPM_BUILD_ROOT%{_sysconfdir} install

%clean
rm -rf $RPM_BUILD_ROOT

%post -p /sbin/ldconfig

%postun -p /sbin/ldconfig

%files
%doc %{_prefix}/share/doc/*
%{_prefix}/bin/gdsl-config
%{_prefix}/lib
%{_prefix}/include/gdsl
%{_prefix}/include/gdsl.h
%{_prefix}/man

