#include <config.h>

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <netdb.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#define PORT "3490" // the port client will be connecting to
#define MAXDATASIZE 1500 // max number of bytes we can get at once
#define IP_ADDRESSES DATA_PATH "/ipaddress.txt" // IP addresses to grep against
// get sockaddr, IPv4 or IPv6:
void *get_in_addr(struct sockaddr *sa){
	if (sa->sa_family == AF_INET) {
		return &(((struct sockaddr_in*)sa)->sin_addr);
	}
	return &(((struct sockaddr_in6*)sa)->sin6_addr);
}
int main(int argc, char *argv[]){
    FILE *fp;
    char buff[20], tmp[200] = "grep ";
	int index = 5, i = 1;

//	printf("argc is : %d\n", argc );
//    for(i=0;i<argc-1;i++){
  //      printf("argv[%d] is %s\n", i, argv[i]);
    //}
	while( index < 200 && i < argc){
		for(int j = 0 ;j < strlen(argv[i]) && index < 200; j++){
			tmp[index++] = argv[i][j];
		}
		tmp[index++] = ' ';
		i++;
	}
	tmp[--index] = '\0';
	//printf("tmp now is: %s\n",tmp);
    if ((fp = fopen(IP_ADDRESSES, "r")) == NULL){
      perror("Error opening file ipaddress.txt");
      return(-1);
    }

while(1){   
    if (fgets(buff, 20, (FILE*)fp)==NULL){
		//puts("End of ipaddress!! \n");
		break;
	}
	for(int i = 0; i<20; i++){
		if(buff[i] == '\n' || buff[i] == ' '){
			buff[i] = '\0';
			break;
		}
	}
    //printf("Connecting to IP: %s\n", buff );

	int sockfd, numbytes;
	char buf[MAXDATASIZE];
	struct addrinfo hints, *servinfo, *p;
	int rv;
	char s[INET6_ADDRSTRLEN];
//	if (argc != 2) {
//		fprintf(stderr,"usage: client hostname\n");
//		exit(1);
//	}
	memset(&hints, 0, sizeof hints);
	hints.ai_family = AF_UNSPEC;
	hints.ai_socktype = SOCK_STREAM;
//printf("11111111111111111111111111111111\n");
//printf("buff: %s\n", buff);
	if ((rv = getaddrinfo(buff, PORT, &hints, &servinfo)) != 0) {
		fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(rv));
		return 1;
	}
//printf("22222222222222222222222222222222\n");
	 // loop through all the results and connect to the first we can
	for(p = servinfo; p != NULL; p = p->ai_next) {
		if ((sockfd = socket(p->ai_family, p->ai_socktype, p->ai_protocol)) == -1) {
			perror("client: socket");
			continue;
		}
		if (connect(sockfd, p->ai_addr, p->ai_addrlen) == -1) {
			close(sockfd);
//			perror("client: connect");
			continue;
 		}
 		break;
 	}
//printf("333333333333333333333333333333333\n");
 	if (p == NULL) {
 		fprintf(stderr, "client: failed to connect\n");
 		//return 2;
 		continue;
 	}
 	inet_ntop(p->ai_family, get_in_addr((struct sockaddr *)p->ai_addr), s, sizeof s);
// 	printf("client: connecting to %s\n", s);
 	freeaddrinfo(servinfo); // all done with this structure
//	printf("client received: \n");
//printf("444444444444444444444444444444444\n");

	if (send(sockfd, tmp, index + 1, 0) == -1)
		perror("send error");

	while(1){
 		if ((numbytes = recv(sockfd, buf, MAXDATASIZE-1, 0)) == -1) {
 			perror("recv");
 			exit(1);
 		}
 		buf[numbytes] = '\0';
		if(numbytes == 0) break;
 		printf("%s",buf);
 	}
	close(sockfd);
}
	fclose(fp);
 	return 0;
}
