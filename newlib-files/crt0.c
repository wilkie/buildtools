extern int main(int, char**); //int argc, char **argv, char **environ);

extern void initC2D();


int _Dmain(int argc, char** argv){
	initC2D();

	return main(argc, argv);
}
