extern int main(int, char**); //int argc, char **argv, char **environ);

extern void initC2D();

int start3(int argc, char** argv){
	unsigned long long *origin, *target;
	int i;

	initC2D();

	for(i = 0; i < argc; i++){
		origin = ((unsigned long long*)argv) + ((i * 2) + 1);
		target = ((unsigned long long*)argv) + i;
		*target = *origin;
	}

	return main(argc, argv);
}
