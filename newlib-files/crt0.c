
extern int main(int argc, char **argv, char **environ);

extern char __bss_start, _end; // BSS should be the last thing before _end

// XXX: environment
char *__env[1] = { 0 };
char **environ = __env;

void _start(){
	asm("popq %rdi; popq %rsi; callq start;");
}

void start(unsigned long long len, char* args){
	int substrings = 1, i = 0;
	char* tmp = args;

	// find the number of arguments
	while((*tmp) != '\0'){
		if(*tmp == ' '){substrings++;}
		tmp++;
	}

	// this will become argv, its allocated on the stack
	char* argv[substrings];

	// build argv and turn spaces into terminators
	tmp = args;
	argv[0] = args;

	while((*tmp) != '\0'){
		if(*tmp == ' '){
			i++;
			*tmp = '\0';
			tmp++;
			argv[i] = tmp;
		}else{
			tmp++;
		}
	}

	// zero BSS
  for(tmp = &__bss_start; tmp < &_end; tmp++){
    *tmp = 0; 
  } 


  exit(main(substrings,&argv[0], __env));
}
