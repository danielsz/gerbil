;;; -*- Scheme -*-
;;; (C) vyzo at hackzen.org
;;; OS socket FFI

(declare
  (block)
  (standard-bindings)
  (extended-bindings)
  (not safe))

(namespace ("std/os/_socket#"))
(##namespace ("" define-macro define let let* if or and
              quote quasiquote unquote unquote-splicing
              c-lambda c-define-type c-declare c-initialize
              declare foreign? foreign-tags memq
              ))

(c-declare #<<END-C
#include <errno.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <netinet/tcp.h>
#include <sys/un.h>
#include <sys/time.h>
#include <stdlib.h>
#include <string.h>

#define U8_DATA(obj) ___CAST (___U8*, ___BODY_AS (obj, ___tSUBTYPED))
#define U8_LEN(obj) ___HD_BYTES (___HEADER (obj))
END-C
)

(define-macro (define-c-lambda id args ret #!optional (name #f))
  (let ((name (or name (##symbol->string id))))
    `(define ,id
       (c-lambda ,args ,ret ,name))))

(define-macro (define-const symbol)
  (let* ((str (##symbol->string symbol))
         (ref (##string-append "___return (" str ");")))
    `(define ,symbol
       ((c-lambda () int ,ref)))))

(define-macro (define-compat symbol #!optional (val -1))
  (let* ((str (##symbol->string symbol))
         (sval (##number->string val))
         (ifdef (##string-append "#ifndef " str "\n"
                                 "#define " str " " sval "\n"
                                 "#endif\n")))
    `(c-declare ,ifdef)))

;;; Constants
(define-const  AF_UNSPEC)
(define-const  AF_UNSPEC)
(define-const  AF_INET)
(define-const  AF_INET6)
(define-const  AF_UNIX)
(define-const  AF_LOCAL)
(define-compat AF_NETLINK)
(define-const  AF_NETLINK)
(define-compat AF_PACKET)
(define-const  AF_PACKET)
(define-compat AF_ALG)
(define-const  AF_ALG)

(define-const  SOCK_STREAM)
(define-const  SOCK_DGRAM)
(define-const  SOCK_RAW)
(define-compat SOCK_SEQPACKET)
(define-const  SOCK_SEQPACKET)
(define-compat SOCK_RDM)
(define-const  SOCK_RDM)

(define-const SHUT_RD)
(define-const SHUT_WR)
(define-const SHUT_RDWR)

(define-compat UNIX_MAX_PATH 108)
(define-const  UNIX_MAX_PATH)

(define-const  SOL_SOCKET)
(define-compat SO_ACCEPTCONN)
(define-const  SO_ACCEPTCONN)
(define-compat SO_BINDTODEVICE)
(define-const  SO_BINDTODEVICE)
(define-compat SO_BROADCAST)
(define-const  SO_BROADCAST)
(define-compat SO_DEBUG)
(define-const  SO_DEBUG)
(define-compat SO_DOMAIN)
(define-const  SO_DOMAIN)
(define-compat SO_DONTROUTE)
(define-const  SO_DONTROUTE)
(define-compat SO_ERROR)
(define-const  SO_ERROR)
(define-compat SO_KEEPALIVE)
(define-const  SO_KEEPALIVE)
(define-compat SO_LINGER)
(define-const  SO_LINGER)
(define-compat SO_OOBLINE)
(define-const  SO_OOBLINE)
(define-compat SO_PASSCRED)
(define-const  SO_PASSCRED)
(define-compat SO_PEERCRED)
(define-const  SO_PEERCRED)
(define-compat SO_PEEK_OFF)
(define-const  SO_PEEK_OFF)
(define-compat SO_PROTOCOL)
(define-const  SO_PROTOCOL)
(define-compat SO_RCVBUF)
(define-const  SO_RCVBUF)
(define-compat SO_SNDBUF)
(define-const  SO_SNDBUF)
(define-compat SO_RCVLOWAT)
(define-const  SO_RCVLOWAT)
(define-compat SO_SNDLOWAT)
(define-const  SO_SNDLOWAT)
(define-compat SO_RCVTIMEO)
(define-const  SO_RCVTIMEO)
(define-compat SO_SNDTIMEO)
(define-const  SO_SNDTIMEO)
(define-compat SO_REUSEADDR)
(define-const  SO_REUSEADDR)
(define-compat SO_REUSEPORT)
(define-const  SO_REUSEPORT)
(define-compat SO_TYPE)
(define-const  SO_TYPE)
(define-compat SO_TIMESTAMP)
(define-const  SO_TIMESTAMP)
(define-compat SO_USELOOPBACK)
(define-const  SO_USELOOPBACK)

(define-const  IPPROTO_IP)
(define-compat IP_ADD_MEMBERSHIP)
(define-const  IP_ADD_MEMBERSHIP)
(define-compat IP_DROP_MEMBERSHIP)
(define-const  IP_DROP_MEMBERSHIP)
(define-compat IP_ADD_SOURCE_MEMBERSHIP)
(define-const  IP_ADD_SOURCE_MEMBERSHIP)
(define-compat IP_DROP_SOURCE_MEMBERSHIP)
(define-const  IP_DROP_SOURCE_MEMBERSHIP)
(define-compat IP_BLOCK_SOURCE)
(define-const  IP_BLOCK_SOURCE)
(define-compat IP_UNBLOCK_SOURCE)
(define-const  IP_UNBLOCK_SOURCE)
(define-compat IP_FREEBIND)
(define-const  IP_FREEBIND)
(define-compat IP_HDRINCL)
(define-const  IP_HDRINCL)
(define-compat IP_MTU)
(define-const  IP_MTU)
(define-compat IP_MTU_DISCOVER)
(define-const  IP_MTU_DISCOVER)
(define-compat IP_MULTICAST_ALL)
(define-const  IP_MULTICAST_ALL)
(define-compat IP_MULTICAST_IF)
(define-const  IP_MULTICAST_IF)
(define-compat IP_MULTICAST_LOOP)
(define-const  IP_MULTICAST_LOOP)
(define-compat IP_MULTICAST_TTL)
(define-const  IP_MULTICAST_TTL)
(define-compat IP_NODEFRAG)
(define-const  IP_NODEFRAG)
(define-compat IP_OPTIONS)
(define-const  IP_OPTIONS)
(define-compat IP_PKTINFO)
(define-const  IP_PKTINFO)
(define-compat IP_RECVERR)
(define-const  IP_RECVERR)
(define-compat IP_RECVORIGDSTADDR)
(define-const  IP_RECVORIGDSTADDR)
(define-compat IP_RECVOPTS)
(define-const  IP_RECVOPTS)
(define-compat IP_RECVTOS)
(define-const  IP_RECVTOS)
(define-compat IP_RECVTTL)
(define-const  IP_RECVTTL)
(define-compat IP_RETOPTS)
(define-const  IP_RETOPTS)
(define-compat IP_ROUTER_ALERT)
(define-const  IP_ROUTER_ALERT)
(define-compat IP_TOS)
(define-const  IP_TOS)
(define-compat IP_TTL)
(define-const  IP_TTL)

(define-const  IPPROTO_IPV6)
(define-compat IPV6_ADDRFORM)
(define-const  IPV6_ADDRFORM)
(define-compat IPV6_ADD_MEMBERSHIP)
(define-const  IPV6_ADD_MEMBERSHIP)
(define-compat IPV6_DROP_MEMBERSHIP)
(define-const  IPV6_DROP_MEMBERSHIP)
(define-compat IPV6_MTU)
(define-const  IPV6_MTU)
(define-compat IPV6_MTU_DISCOVER)
(define-const  IPV6_MTU_DISCOVER)
(define-compat IPV6_MULTICAST_HOPS)
(define-const  IPV6_MULTICAST_HOPS)
(define-compat IPV6_MULTICAST_IF)
(define-const  IPV6_MULTICAST_IF)
(define-compat IPV6_MULTICAST_LOOP)
(define-const  IPV6_MULTICAST_LOOP)
(define-compat IPV6_RECVPKTINFO)
(define-const  IPV6_RECVPKTINFO)
(define-compat IPV6_RTHDR)
(define-const  IPV6_RTHDR)
(define-compat IPV6_AUTHHDR)
(define-const  IPV6_AUTHHDR)
(define-compat IPV6_DSTOPTS)
(define-const  IPV6_DSTOPTS)
(define-compat IPV6_HOPOPTS)
(define-const  IPV6_HOPOPTS)
(define-compat IPV6_FLOWINFO)
(define-const  IPV6_FLOWINFO)
(define-compat IPV6_HOPLIMIT)
(define-const  IPV6_HOPLIMIT)
(define-compat IPV6_ROUTER_ALERT)
(define-const  IPV6_ROUTER_ALERT)
(define-compat IPV6_UNICAST_HOPS)
(define-const  IPV6_UNICAST_HOPS)
(define-compat IPV6_V6ONLY)
(define-const  IPV6_V6ONLY)

(define-const  IPPROTO_TCP)
(define-compat TCP_CONGESTION)
(define-const  TCP_CONGESTION)
(define-compat TCP_CORK)
(define-const  TCP_CORK)
(define-compat TCP_DEFER_ACCEPT)
(define-const  TCP_DEFER_ACCEPT)
(define-compat TCP_KEEPCNT)
(define-const  TCP_KEEPCNT)
(define-compat TCP_KEEPIDLE)
(define-const  TCP_KEEPIDLE)
(define-compat TCP_KEEPINTVL)
(define-const  TCP_KEEPINTVL)
(define-compat TCP_MAXSEG)
(define-const  TCP_MAXSEG)
(define-compat TCP_NODELAY)
(define-const  TCP_NODELAY)
(define-compat TCP_SYNCNT)
(define-const  TCP_SYNCNT)

(define-compat IP_PMTUDISC_WANT)
(define-const  IP_PMTUDISC_WANT)
(define-compat IP_PMTUDISC_DONT)
(define-const  IP_PMTUDISC_DONT)
(define-compat IP_PMTUDISC_DO)
(define-const  IP_PMTUDISC_DO)
(define-compat IP_PMTUDISC_PROBE)
(define-const  IP_PMTUDISC_PROBE)
(define-compat IPTOS_LOWDELAY)
(define-const  IPTOS_LOWDELAY)
(define-compat IPTOS_THROUGHPUT)
(define-const  IPTOS_THROUGHPUT)
(define-compat IPTOS_RELIABILITY)
(define-const  IPTOS_RELIABILITY)
(define-compat IPTOS_MINCOST)
(define-const  IPTOS_MINCOST)
(define-compat MSG_DONTROUTE)
(define-const  MSG_DONTROUTE)
(define-compat MSG_DONTWAIT)
(define-const  MSG_DONTWAIT)
(define-compat MSG_MORE)
(define-const  MSG_MORE)
(define-compat MSG_OOB)

(c-declare #<<END-C
static ___SCMOBJ ffi_free (void *ptr);
static int ffi_bind (int fd, struct sockaddr *sa);
static int ffi_accept (int fd, struct sockaddr *sa);
static int ffi_connect (int fd, struct sockaddr *sa);
static int ffi_send (int fd, ___SCMOBJ bytes, int start, int end, int flags);
static int ffi_sendto (int fd, ___SCMOBJ bytes, int start, int end, int flags, struct sockaddr *sa);
static int ffi_recv (int fd, ___SCMOBJ bytes, int start, int end, int flags);
static int ffi_recvfrom (int fd, ___SCMOBJ bytes, int start, int end, int flags, struct sockaddr *sa);
static int ffi_getpeername (int fd, struct sockaddr *sa);
static int ffi_getsockname (int fd, struct sockaddr *sa);
static struct sockaddr *ffi_make_sockaddr_in ();
static struct sockaddr *ffi_make_sockaddr_in6 ();
static struct sockaddr *ffi_make_sockaddr_un ();
static void ffi_sockaddr_in_addr (struct sockaddr *sa, ___SCMOBJ bytes);
static void ffi_sockaddr_in_addr_set (struct sockaddr *sa, ___SCMOBJ bytes);
static int ffi_sockaddr_in_port (struct sockaddr *sa);
static void ffi_sockaddr_in_port_set (struct sockaddr *sa, int port);
static void ffi_sockaddr_in6_addr (struct sockaddr *sa, ___SCMOBJ bytes);
static void ffi_sockaddr_in6_addr_set (struct sockaddr *sa, ___SCMOBJ bytes);
static int ffi_sockaddr_in6_port (struct sockaddr *sa);
static void ffi_sockaddr_in6_port_set (struct sockaddr *sa, int port);
static char *ffi_sockaddr_un_path (struct sockaddr *sa);
static void ffi_sockaddr_un_path_set (struct sockaddr *sa, char *path);
static int ffi_getsockopt_int (int fd, int level, int opt);
static int ffi_setsockopt_int (int fd, int level, int opt, int val);
static int ffi_getsockopt_tv (int fd, int level, int opt, struct timeval *tv);
static int ffi_setsockopt_tv (int fd, int level, int opt, struct timeval *tv);
static int ffi_getsockopt_sa (int fd, int level, int opt, struct sockaddr *sa);
static int ffi_setsockopt_sa (int fd, int level, int opt, struct sockaddr *sa);
static int ffi_setsockopt_mreq (int fd, int level, int opt, ___SCMOBJ maddr, ___SCMOBJ laddr);
static int ffi_setsockopt_mreq_src (int fd, int level, int opt, ___SCMOBJ maddr, ___SCMOBJ iaddr, ___SCMOBJ saddr);
static int ffi_setsockopt_mreq6 (int fd, int level, int opt, ___SCMOBJ maddr, int ifindex);
static int ffi_getsockopt_bytes (int fd, int level, int opt, ___SCMOBJ bytes);
static int ffi_setsockopt_bytes (int fd, int level, int opt, ___SCMOBJ bytes);
static int ffi_getsockopt_linger (int fd, int level, int opt, struct linger *linger);
static int ffi_setsockopt_linger (int fd, int level, int opt, struct linger *linger);
static struct timeval *ffi_make_tv ();
static struct linger *ffi_make_linger ();
END-C
)

(c-define-type sockaddr (struct "sockaddr"))
(c-define-type sockaddr*
  (pointer sockaddr (sockaddr*) "ffi_free"))

(c-define-type timeval (struct "timeval"))
(c-define-type timeval*
  (pointer timeval (timeval*) "ffi_free"))

(c-define-type linger (struct "linger"))
(c-define-type linger*
  (pointer linger (linger*) "ffi_free"))

(define-c-lambda __errno () int
  "___return (errno);")

(define-macro (define-with-errno symbol ffi-symbol args)
  `(define (,symbol ,@args)
     (declare (not interrupts-enabled))
     (let ((r (,ffi-symbol ,@args)))
       (if (##fx< r 0)
         (##fx- (__errno))
         r))))

(define-c-lambda __socket (int int int) int
  "socket")
(define-c-lambda __bind (int sockaddr*) int
  "ffi_bind")
(define-c-lambda __listen (int int) int
  "listen")
(define-c-lambda __accept (int sockaddr*) int
  "ffi_accept")
(define-c-lambda __connect (int sockaddr*) int
  "ffi_connect")
(define-c-lambda __shutdown (int int) int
  "shutdown")
  
(define-c-lambda __send (int scheme-object int int int) int
  "ffi_send")
(define-c-lambda __sendto (int scheme-object int int int sockaddr*) int
  "ffi_sendto")
;; __sendmsg
(define-c-lambda __recv (int scheme-object int int int) int
  "ffi_recv")
(define-c-lambda __recvfrom (int scheme-object int int int sockaddr*) int
  "ffi_recvfrom")
;; __recvmsg

(define-c-lambda __getpeername (int sockaddr*) int
  "ffi_getpeername")
(define-c-lambda __getsockname (int sockaddr*) int
  "ffi_getsockname")

(define-with-errno _socket __socket (domain type proto))
(define-with-errno _bind __bind (fd sa))
(define-with-errno _listen __listen (fd backlog))
(define-with-errno _accept __accept (fd sa))
(define-with-errno _connect __connect (fd sa))
(define-with-errno _shutdown __shutdown (fd how))
  
(define-with-errno _send __send (fd bytes start end flags))
(define-with-errno _sendto __sendto (fd bytes start end flags sa))
;; _sendmsg
(define-with-errno _recv __recv (fd bytes start end flags))
(define-with-errno _recvfrom __recvfrom (fd bytes start end flags sa))
;; _recvmsg

(define-with-errno _getpeername __getpeername (fd sa))
(define-with-errno _getsockname __getsockname (fd sa))

(define-c-lambda make_sockaddr_in () sockaddr*
  "ffi_make_sockaddr_in")
(define-c-lambda make_sockaddr_in6 () sockaddr*
  "ffi_make_sockaddr_in6")
(define-c-lambda make_sockaddr_un () sockaddr*
  "ffi_make_sockaddr_un")

(define (sockaddr? obj)
  (and (foreign? obj)
       (memq 'sockaddr* (foreign-tags obj))))

(define-c-lambda sockaddr_family (sockaddr*) int
  "___return (___arg1->sa_family);")
(define-c-lambda sockaddr_in_addr (sockaddr* scheme-object) void
  "ffi_sockaddr_in_addr")
(define-c-lambda sockaddr_in_addr_set (sockaddr* scheme-object) void
  "ffi_sockaddr_in_addr_set")
(define-c-lambda sockaddr_in_port (sockaddr*) int
  "ffi_sockaddr_in_port")
(define-c-lambda sockaddr_in_port_set (sockaddr* int) void
  "ffi_sockaddr_in_port_set")
(define-c-lambda sockaddr_in6_addr (sockaddr* scheme-object) void
  "ffi_sockaddr_in6_addr")
(define-c-lambda sockaddr_in6_addr_set (sockaddr* scheme-object) void
  "ffi_sockaddr_in6_addr_set")
(define-c-lambda sockaddr_in6_port (sockaddr*) int
  "ffi_sockaddr_in6_port")
(define-c-lambda sockaddr_in6_port_set (sockaddr* int) void
  "ffi_sockaddr_in6_port_set")
(define-c-lambda sockaddr_un_path (sockaddr*) UTF-8-string
  "ffi_sockaddr_un_path")
(define-c-lambda sockaddr_un_path_set (sockaddr* UTF-8-string) void
  "ffi_sockaddr_un_path_set")

(define-c-lambda __getsockopt_int (int int int) int
  "ffi_getsockopt_int")
(define-c-lambda __setsockopt_int (int int int int) int
  "ffi_setsockopt_int")
(define-c-lambda __getsockopt_tv (int int int timeval*) int
  "ffi_getsockopt_tv")
(define-c-lambda __setsockopt_tv (int int int timeval*) int
  "ffi_setsockopt_tv")
(define-c-lambda __getsockopt_sa (int int int sockaddr*) int
  "ffi_getsockopt_sa")
(define-c-lambda __setsockopt_sa (int int int sockaddr*) int
  "ffi_setsockopt_sa")
(define-c-lambda __setsockopt_mreq (int int int scheme-object scheme-object) int
  "ffi_setsockopt_mreq")
(define-c-lambda __setsockopt_mreq_src (int int int scheme-object scheme-object scheme-object) int
  "ffi_setsockopt_mreq_src")
(define-c-lambda __setsockopt_mreq6 (int int int scheme-object int) int
  "ffi_setsockopt_mreq6")
(define-c-lambda __getsockopt_bytes (int int int scheme-object) int
  "ffi_getsockopt_bytes")
(define-c-lambda __setsockopt_bytes (int int int scheme-object) int
  "ffi_setsockopt_bytes")
(define-c-lambda __getsockopt_linger (int int int linger*) int
  "ffi_getsockopt_linger")
(define-c-lambda __setsockopt_linger (int int int linger*) int
  "ffi_setsockopt_linger")

(define-with-errno _getsockopt_int __getsockopt_int (fd level opt))
(define-with-errno _setsockopt_int __setsockopt_int (fd level opt val))
(define-with-errno _getsockopt_tv __getsockopt_tv (fd level opt tv))
(define-with-errno _setsockopt_tv __setsockopt_tv (fd level opt tv))
(define-with-errno _getsockopt_sa __getsockopt_sa (fd level opt sa))
(define-with-errno _setsockopt_sa __setsockopt_sa (fd level opt sa))
(define-with-errno _setsockopt_mreq __setsockopt_mreq (fd level opt maddr laddr))
(define-with-errno _setsockopt_mreq_src __setsockopt_mreq_src (fd level opt maddr iaddr saddr))
(define-with-errno _setsockopt_mreq6 __setsockopt_mreq6 (fd level opt maddr ifindex))
(define-with-errno _getsockopt_bytes __getsockopt_bytes (fd level opt bytes))
(define-with-errno _setsockopt_bytes __setsockopt_bytes (fd level opt bytes))
(define-with-errno _getsockopt_linger __getsockopt_linger (fd level opt linger))
(define-with-errno _setsockopt_linger __setsockopt_linger (fd level opt linger))

(define-c-lambda make_tv () timeval*
  "ffi_make_tv")
(define-c-lambda tv_sec (timeval*) int
  "___return (___arg1->tv_sec);")
(define-c-lambda tv_sec_set (timeval* int) void
  "___arg1->tv_sec = ___arg2; ___return;")
(define-c-lambda tv_usec (timeval*) int
  "___return (___arg1->tv_usec);")
(define-c-lambda tv_usec_set (timeval* int) void
  "___arg1->tv_usec = ___arg2; ___return;")

(define-c-lambda make_linger () linger*
  "ffi_make_linger")
(define-c-lambda linger_onoff (linger*) int
  "___return (___arg1->l_onoff);")
(define-c-lambda linger_onoff_set (linger* int) void
  "___arg1->l_onoff = ___arg2; ___return;")
(define-c-lambda linger_linger (linger*) int
  "___return (___arg1->l_linger);")
(define-c-lambda linger_linger_set (linger* int) void
  "___arg1->l_linger = ___arg2; ___return;")

(c-declare #<<END-C
___SCMOBJ ffi_free (void *ptr)
{
 free (ptr);
 return ___FIX (___NO_ERR);
}

static socklen_t sockaddr_len (struct sockaddr *sa)
{
 switch (sa->sa_family)
 {
  case AF_INET:
   return sizeof (struct sockaddr_in);
  case AF_INET6:
   return sizeof (struct sockaddr_in6);
  case AF_UNIX:
   return sizeof (struct sockaddr_un);
  default:
   errno = EINVAL;
   return -1;
 }
}

#define GETSALEN(sa, salen) \
 socklen_t salen = sockaddr_len (sa); \
 if (salen < 0) return -1;

static int ffi_bind (int fd, struct sockaddr *sa)
{
 GETSALEN (sa, salen);
 return bind (fd, sa, salen);
}

int ffi_accept (int fd, struct sockaddr *sa)
{
 GETSALEN (sa, salen);
 return accept (fd, sa, &salen);
}

int ffi_connect (int fd, struct sockaddr *sa)
{
 GETSALEN (sa, salen);
 return connect (fd, sa, salen);
}

int ffi_send (int fd, ___SCMOBJ bytes, int start, int end, int flags)
{
 return send (fd, U8_DATA (bytes) + start, end - start, flags);
}

int ffi_sendto (int fd, ___SCMOBJ bytes, int start, int end, int flags, struct sockaddr *sa)
{
 GETSALEN (sa, salen);
 return sendto (fd, U8_DATA (bytes) + start, end - start, flags, sa, salen);
}

int ffi_recv (int fd, ___SCMOBJ bytes, int start, int end, int flags)
{
 return recv (fd, U8_DATA (bytes) + start, end - start, flags);
}

int ffi_recvfrom (int fd, ___SCMOBJ bytes, int start, int end, int flags, struct sockaddr *sa)
{
 GETSALEN (sa, salen);
 return recvfrom (fd, U8_DATA (bytes) + start, end - start, flags, sa, &salen);
 }

int ffi_getpeername (int fd, struct sockaddr *sa)
{
 GETSALEN (sa, salen);
 return getpeername (fd, sa, &salen);
}

int ffi_getsockname (int fd, struct sockaddr *sa)
{
 GETSALEN (sa, salen);
 return getsockname (fd, sa, &salen);
}

struct sockaddr *ffi_make_sockaddr_in ()
{
 struct sockaddr *sa = (struct sockaddr*)malloc (sizeof (struct sockaddr_in));
 if (sa)
 {     
  memset (sa, 0, sizeof (struct sockaddr_in));
  sa->sa_family = AF_INET;
 }
 return sa;
}

struct sockaddr *ffi_make_sockaddr_in6 ()
{
 struct sockaddr *sa = (struct sockaddr*)malloc (sizeof (struct sockaddr_in6));
 if (sa)
 {       
  memset (sa, 0, sizeof (struct sockaddr_in6));
  sa->sa_family = AF_INET6;
 }
 return sa;
}

struct sockaddr *ffi_make_sockaddr_un ()
{
 struct sockaddr *sa = (struct sockaddr*)malloc (sizeof (struct sockaddr_un));
 if (sa)
 {       
  memset (sa, 0, sizeof (struct sockaddr_un));
  sa->sa_family = AF_UNIX;
 }
 return sa;
}

void ffi_sockaddr_in_addr (struct sockaddr *sa, ___SCMOBJ bytes)
{
 struct sockaddr_in *sa_in = (struct sockaddr_in*)sa;
 memcpy (U8_DATA (bytes), &sa_in->sin_addr, sizeof (struct in_addr));
}

void ffi_sockaddr_in_addr_set (struct sockaddr *sa, ___SCMOBJ bytes)
{
 struct sockaddr_in *sa_in = (struct sockaddr_in*)sa;
 memcpy (&sa_in->sin_addr, U8_DATA (bytes), sizeof (struct in_addr));
}

int ffi_sockaddr_in_port (struct sockaddr *sa)
{
 struct sockaddr_in *sa_in = (struct sockaddr_in*)sa;
 return sa_in->sin_port;
}

void ffi_sockaddr_in_port_set (struct sockaddr *sa, int port)
{
 struct sockaddr_in *sa_in = (struct sockaddr_in*)sa;
 sa_in->sin_port = port;
}

void ffi_sockaddr_in6_addr (struct sockaddr *sa, ___SCMOBJ bytes)
{
 struct sockaddr_in6 *sa_in6 = (struct sockaddr_in6*)sa;
 memcpy (U8_DATA (bytes), &sa_in6->sin6_addr, sizeof (struct in6_addr));
}

void ffi_sockaddr_in6_addr_set (struct sockaddr *sa, ___SCMOBJ bytes)
{
 struct sockaddr_in6 *sa_in6 = (struct sockaddr_in6*)sa;
 memcpy (&sa_in6->sin6_addr, U8_DATA (bytes), sizeof (struct in6_addr));
}

int ffi_sockaddr_in6_port (struct sockaddr *sa)
{
 struct sockaddr_in6 *sa_in6 = (struct sockaddr_in6*)sa;
 return sa_in6->sin6_port;
}

void ffi_sockaddr_in6_port_set (struct sockaddr *sa, int port)
{
 struct sockaddr_in6 *sa_in6 = (struct sockaddr_in6*)sa;
 sa_in6->sin6_port = port;
}

char *ffi_sockaddr_un_path (struct sockaddr *sa)
{
 struct sockaddr_un *sa_un = (struct sockaddr_un*)sa;
 return sa_un->sun_path;
}

void ffi_sockaddr_un_path_set (struct sockaddr *sa, char *path)
{
 struct sockaddr_un *sa_un = (struct sockaddr_un*)sa;
 strncpy (sa_un->sun_path, path, sizeof (sa_un->sun_path));      
}

int ffi_getsockopt_int (int fd, int level, int opt)
{
 int val;
 socklen_t olen = sizeof (int);
 int r = getsockopt (fd, level, opt, &val, &olen);
 if (r < 0) return r;
 return val;
}

int ffi_setsockopt_int (int fd, int level, int opt, int val)
{
 socklen_t olen = sizeof (int);
 return setsockopt (fd, level, opt, &val, olen);
 }

int ffi_getsockopt_tv (int fd, int level, int opt, struct timeval *tv)
{
 socklen_t olen = sizeof (struct timeval);
 return getsockopt (fd, level, opt, tv, &olen);
}

int ffi_setsockopt_tv (int fd, int level, int opt, struct timeval *tv)
{
 socklen_t olen = sizeof (struct timeval);
 return setsockopt (fd, level, opt, tv, olen);
}

static int ffi_getsockopt_sa (int fd, int level, int opt, struct sockaddr *sa)
{
 GETSALEN (sa, salen);
 return getsockopt (fd, level, opt, sa, &salen);
}

int ffi_setsockopt_sa (int fd, int level, int opt, struct sockaddr *sa)
{
 GETSALEN (sa, salen);
 return setsockopt (fd, level, opt, sa, salen);
}

int ffi_setsockopt_mreq (int fd, int level, int opt, ___SCMOBJ maddr, ___SCMOBJ laddr)
{
 struct ip_mreq mreq;
 socklen_t olen = sizeof (struct ip_mreq);
 memcpy (&mreq.imr_multiaddr, U8_DATA (maddr), sizeof (struct in_addr));
 memcpy (&mreq.imr_interface, U8_DATA (laddr), sizeof (struct in_addr));
 return setsockopt (fd, level, opt, &mreq, olen);
}

int ffi_setsockopt_mreq_src (int fd, int level, int opt, ___SCMOBJ maddr, ___SCMOBJ iaddr, ___SCMOBJ saddr)
{
 struct ip_mreq_source mreq;
 socklen_t olen = sizeof (struct ip_mreq_source);
 memcpy (&mreq.imr_multiaddr, U8_DATA (maddr), sizeof (struct in_addr));
 memcpy (&mreq.imr_interface, U8_DATA (iaddr), sizeof (struct in_addr));
 memcpy (&mreq.imr_sourceaddr, U8_DATA (saddr), sizeof (struct in_addr));
 return setsockopt (fd, level, opt, &mreq, olen);
}

int ffi_setsockopt_mreq6 (int fd, int level, int opt, ___SCMOBJ maddr, int ifindex)
{
 struct ipv6_mreq mreq;
 socklen_t olen = sizeof (struct ipv6_mreq);
 memcpy (&mreq.ipv6mr_multiaddr, U8_DATA (maddr), sizeof (struct in6_addr));
 memcpy (&mreq.ipv6mr_interface, &ifindex, sizeof (int));
 return setsockopt (fd, level, opt, &mreq, olen);
}

int ffi_getsockopt_bytes (int fd, int level, int opt, ___SCMOBJ bytes)
{
 socklen_t olen = U8_LEN (bytes);
 int r = getsockopt (fd, level, opt, U8_DATA (bytes), &olen);
 if (r < 0)
  return r;
 return olen;
}

int ffi_setsockopt_bytes (int fd, int level, int opt, ___SCMOBJ bytes)
{
 socklen_t olen = U8_LEN (bytes);
 return setsockopt (fd, level, opt, U8_DATA (bytes), olen);
}

int ffi_getsockopt_linger (int fd, int level, int opt, struct linger *linger)
{
 socklen_t olen = sizeof (struct linger);
 return getsockopt (fd, level, opt, linger, &olen);
}

int ffi_setsockopt_linger (int fd, int level, int opt, struct linger *linger)
{
 socklen_t olen = sizeof (struct linger);
 return setsockopt (fd, level, opt, linger, olen);
}

struct timeval *ffi_make_tv ()
{
 return (struct timeval*)malloc (sizeof (struct timeval));
}

struct linger *ffi_make_linger ()
{
 return (struct linger*)malloc (sizeof (struct linger));
}
END-C
)