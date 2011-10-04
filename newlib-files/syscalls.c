
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

// --- Process Control ---
int
_exit(int val){
  __exit(val);
  return (-1);
}

int
_execve(char *name, char **argv, char **env) {
	errno = ENOMEM;
	return -1;
}

/*
 * getpid -- only one process, so just return 1.
 */
#define __MYPID 1
int
getpid()
{
  return __MYPID;
}


int
fork(void) {
	errno = ENOTSUP;
	return -1;
}


/*
 * kill -- go out via exit...
 */
int
kill(pid, sig)
     int pid;
     int sig;
{
  if(pid == __MYPID)
    _exit(sig);


	errno = EINVAL;
  return -1;
}

int
wait(int *status) {
	errno = ECHILD;
	return -1;
}

// --- I/O ---

/*
 * isatty -- returns 1 if connected to a terminal device,
 *           returns 0 if not. Since we're hooked up to a
 *           serial port, we'll say yes and return a 1.
 */


int gibOpen(const char* name, unsigned int nameLen, bool readOnly, bool append, bool create);
int gibRead(int fd, void* buf, unsigned int len);
int gibWrite(int fd, void* buf, unsigned int len);
unsigned long long initHeap();


int
_isatty(fd)
     int fd;
{
	if(fd < 3){
		return 1;
	}else{
		return 0;
	}
}

int
open(const char *name, int flags, ...) {
	int nameLen = strlen(name);
	bool readOnly = false,  append = false, create = true;
	int fd;

	// O_RDONLY isn't Quite a flag, is defined as 0
	if( flags == O_RDONLY ){
		readOnly = true;
	}

	fd = gibOpen(name, nameLen, readOnly, append, create);

	if(fd == -1){
		errno = ENFILE;
		return -1;
	}

	return fd;
}

int
close(int file) {
	int err = gibClose(file);

	if(err < 0){
		errno = EBADF;
		return -1;
	}else{
		return 0;
	}
}

int
read(int file, char *ptr, int len) {
	// XXX: keyboard support
	if(file < 3){
		return -1;
	}

	int err = gibRead(file, ptr, len);

	if(err == -1){
		errno = EBADF;
	}

	return err;
}

int
write(int file, char *ptr, int len) {
	if(file == 1 || file == 2){
		wconsole(ptr, len);

		return len;
	}

	int err =  gibWrite(file, ptr, len);

	if(err >= 0){
		return err;
	}else{
		errno = EBADF;
		return -1;
	}
}


/* XXX: implement these */
int
lseek(int file, int ptr, int dir) {
	return 0;
}


int
fstat(int file, struct stat *st) {
	st->st_mode = S_IFCHR;
	return 0;
}

int
stat(const char *file, struct stat *st){
	st->st_mode = S_IFCHR;
	return 0;
}

int
link(char *old, char *new) {
	errno = EMLINK;
	return -1;
}

int
unlink(char *name) {
	errno = ENOENT;
	return -1;
}


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


// some additional functions that aren't provided by default

static int fail();

// missing binutils deps: fnctl, umask, chmod, access, lstat, pathconf, utime

int fcntl(int fd, int cmd, ... ){
	errno = ENOSYS;
  return -1;
}

mode_t umask(mode_t mask){
	return 0777;
}

int chmod(const char *path, mode_t mode){
	errno = ENOSYS;
  return -1;
}

int chown(const char *path, uid_t owner, gid_t group){
	errno = ENOSYS;
  return -1;
}

int access(const char *pathname, int mode){
	errno = ENOSYS;
  return -1;
}

int lstat(const char *path, struct stat *buf){
	return stat(path, buf);
}

long pathconf(char *path, int name){
	// no limits
	return -1;
}

int utime(const char *filename, const struct utimbuf *times){
	// I ain't tellin'
	errno = EPERM;
  return -1;
}

// missing gcc deps: sleep, alarm, pipe, dup2, execvp

unsigned int sleep(unsigned int seconds){
	return 0;
}

unsigned int alarm(unsigned int seconds){
	return 0;
}

int pipe(int pipefd[2]){
	return fail();
}

int dup(int oldfd){
	// XXX: find a free fd
	return dup2(oldfd, 7);
}

int dup2(int oldfd, int newfd){
	return fail();
}

int getdents(unsigned int fd, struct linux_dirent *dirp,
						 unsigned int count){
	return fail();
}

long sysconf(int name){
	return fail();
}

int chdir(const char *path){
	return fail();
}

int getrusage(int who, struct rusage *usage){
	return fail();
}

int fail(){
	errno = ENOSYS;
  return -1;
}

