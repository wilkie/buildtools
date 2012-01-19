
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/fcntl.h>
#include <sys/times.h>
#include <sys/errno.h>
#include <sys/time.h>
#include <stdio.h>

#include <stdbool.h>

//#include <_ansi.h>
#include <errno.h>

// first, the 13 required calls




/*
 * kill -- go out via exit...
 */



/*
 * isatty -- returns 1 if connected to a terminal device,
 *           returns 0 if not. Since we're hooked up to a
 *           serial port, we'll say yes and return a 1.
 */


unsigned long long initHeap();


// --- Memory ---
#define PAGE_SIZE 4096ULL
#define PAGE_MASK 0xFFFFFFFFFFFFF000ULL

/*
 * sbrk -- changes heap size size. Get nbytes more
 *         RAM. We just increment a pointer in what's
 *         left of memory on the board.
 */
caddr_t
sbrk(int nbytes){
  static unsigned long long heap_ptr = 0;
  caddr_t base;

  int temp;

  if(heap_ptr == 0){
    heap_ptr = initHeap();
  }

  base = (caddr_t)heap_ptr;

	if(nbytes < 0){
		heap_ptr -= nbytes;
		return base;
	}

  if( (heap_ptr & ~PAGE_MASK) != 0ULL){
    temp = (PAGE_SIZE - (heap_ptr & ~PAGE_MASK));

    if( nbytes < temp ){
      heap_ptr += nbytes;
      nbytes = 0;
    }else{
      heap_ptr += temp;
      nbytes -= temp;
    }
  }

  while(nbytes > PAGE_SIZE){
    nbytes -= (int) PAGE_SIZE;
    heap_ptr = heap_ptr + PAGE_SIZE;
  }

  if( nbytes > 0){
    heap_ptr += nbytes;
  }


  return base;
}


// --- Other ---
 int gettimeofday(struct timeval *p, void *z){
	 return -1;
 }


static int fail();

int utime(const char *filename, const struct utimbuf *times){
	// I ain't tellin'
	errno = EPERM;
  return -1;
}

int getdents(unsigned int fd, struct linux_dirent *dirp,
						 unsigned int count){
	return fail();
}

int getrusage(int who, struct rusage *usage){
	return fail();
}

/*int fail(){
	errno = ENOSYS;
  return -1;
	}*/

