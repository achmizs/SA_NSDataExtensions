//
//  NSData+SA_NSDataExtensions.m
//
//  Copyright 2015-2021 Said Achmiz.
//  See LICENSE and README.md for more info.

#import "NSData+SA_NSDataExtensions.h"

@implementation NSData (SA_NSDataExtensions)

-(BOOL) isNullTerminated {
	if (self.length == 0)
		return NO;

	return (((char*) self.bytes)[self.length - 1] == '\0');
}

-(const char *) SA_terminatedCString {
	return self.SA_dataWithTerminatedCString.bytes;
}

-(NSData *) SA_dataWithTerminatedCString {
	if (self.length == 0) {
		return [NSData dataWithBytes:"\0" 
							  length:1];
	} else if (self.isNullTerminated) {
		return self;
	} else {
		char* terminated_string_buffer = malloc(self.length + 1);
		[self getBytes:terminated_string_buffer 
				length:self.length];
		terminated_string_buffer[self.length] = '\0';
		
		return [NSData dataWithBytesNoCopy:terminated_string_buffer 
									length:(self.length + 1) 
							  freeWhenDone:YES];
	}
}

-(const char *) SA_unterminatedByteString {
	return self.SA_dataWithUnterminatedByteString.bytes;
}

-(NSData *) SA_dataWithUnterminatedByteString {
	if (self.length == 0 || self.isNullTerminated == NO) {
		return self;
	} else {
		char* unterminated_string_buffer = malloc(self.length - 1);
		[self getBytes:unterminated_string_buffer length:self.length - 1];
		
		return [NSData dataWithBytesNoCopy:unterminated_string_buffer 
									length:(self.length - 1) 
							  freeWhenDone:YES];
	}
}

+(NSData *) dataWithBlankCString {
	return [NSData dataWithBytes:"\0" 
						  length:1];
}

+(NSData *) dataFromCString:(const char *)cString {
	return [NSData dataWithBytes:cString
						  length:strlen(cString)];
}

+(NSData *) dataWithCString:(char *)cString {
	return [NSData dataWithBytesNoCopy:cString
								length:strlen(cString)];
}

@end
