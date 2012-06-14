extern int ioperm (unsigned long int __from, unsigned long int __num,
                   int __turn_on) __attribute__ ((__nothrow__ ));


//extern int iopl (int __level) __attribute__ ((__nothrow__ ));
int iopl(int level){return 0;}

static __inline unsigned char
inb (unsigned short int __port)
{
  unsigned char _v;

  __asm__ __volatile__ ("inb %w1,%0":"=a" (_v):"Nd" (__port));
  return _v;
}

static __inline unsigned char
inb_p (unsigned short int __port)
{
  unsigned char _v;

  __asm__ __volatile__ ("inb %w1,%0\noutb %%al,$0x80":"=a" (_v):"Nd" (__port));
  return _v;
}

static __inline unsigned short int
inw (unsigned short int __port)
{
  unsigned short _v;

  __asm__ __volatile__ ("inw %w1,%0":"=a" (_v):"Nd" (__port));
  return _v;
}

static __inline unsigned short int
inw_p (unsigned short int __port)
{
  unsigned short int _v;

  __asm__ __volatile__ ("inw %w1,%0\noutb %%al,$0x80":"=a" (_v):"Nd" (__port));
  return _v;
}

static __inline unsigned int
inl (unsigned short int __port)
{
  unsigned int _v;

  __asm__ __volatile__ ("inl %w1,%0":"=a" (_v):"Nd" (__port));
  return _v;
}

static __inline unsigned int
inl_p (unsigned short int __port)
{
  unsigned int _v;
  __asm__ __volatile__ ("inl %w1,%0\noutb %%al,$0x80":"=a" (_v):"Nd" (__port));
  return _v;
}

static __inline void
outb (unsigned char __value, unsigned short int __port)
{
  __asm__ __volatile__ ("outb %b0,%w1": :"a" (__value), "Nd" (__port));
}

static __inline void
outb_p (unsigned char __value, unsigned short int __port)
{
  __asm__ __volatile__ ("outb %b0,%w1\noutb %%al,$0x80": :"a" (__value),
   "Nd" (__port));
}

static __inline void
outw (unsigned short int __value, unsigned short int __port)
{
  __asm__ __volatile__ ("outw %w0,%w1": :"a" (__value), "Nd" (__port));

}

static __inline void
outw_p (unsigned short int __value, unsigned short int __port)
{
  __asm__ __volatile__ ("outw %w0,%w1\noutb %%al,$0x80": :"a" (__value),
   "Nd" (__port));
}

static __inline void
outl (unsigned int __value, unsigned short int __port)
{
  __asm__ __volatile__ ("outl %0,%w1": :"a" (__value), "Nd" (__port));
}

static __inline void
outl_p (unsigned int __value, unsigned short int __port)
{
  __asm__ __volatile__ ("outl %0,%w1\noutb %%al,$0x80": :"a" (__value),
   "Nd" (__port));
}

static __inline void
insb (unsigned short int __port, void *addr, unsigned long int __count)
{
  __asm__ __volatile__ ("cld ; rep ; insb":"=D" (addr), "=c" (__count)
   :"d" (__port), "0" (addr), "1" (__count));
}

static __inline void
insw (unsigned short int __port, void *addr, unsigned long int __count)
{
  __asm__ __volatile__ ("cld ; rep ; insw":"=D" (addr), "=c" (__count)
   :"d" (__port), "0" (addr), "1" (__count));
}

static __inline void
insl (unsigned short int __port, void *addr, unsigned long int __count)
{
  __asm__ __volatile__ ("cld ; rep ; insl":"=D" (addr), "=c" (__count)
   :"d" (__port), "0" (addr), "1" (__count));
}

static __inline void
outsb (unsigned short int __port, const void *addr, unsigned long int __count)
{
  __asm__ __volatile__ ("cld ; rep ; outsb":"=S" (addr), "=c" (__count)
   :"d" (__port), "0" (addr), "1" (__count));
}

static __inline void
outsw (unsigned short int __port, const void *addr, unsigned long int __count)
{
  __asm__ __volatile__ ("cld ; rep ; outsw":"=S" (addr), "=c" (__count)
     :"d" (__port), "0" (addr), "1" (__count));
}

static __inline void
outsl (unsigned short int __port, const void *addr, unsigned long int __count)
{
  __asm__ __volatile__ ("cld ; rep ; outsl":"=S" (addr), "=c" (__count)
   :"d" (__port), "0" (addr), "1" (__count));
}
