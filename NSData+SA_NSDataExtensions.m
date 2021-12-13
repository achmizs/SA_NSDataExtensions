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

-(const char *) terminatedCString {
	return self.dataWithTerminatedCString.bytes;
}

-(NSData *) dataWithTerminatedCString {
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

-(NSRange) startRange {
	return NSMakeRange(0, 0);
}

-(NSRange) fullRange {
	return NSMakeRange(0, self.length);
}

-(NSRange) endRange {
	return NSMakeRange(self.length, 0);
}

-(NSRange) rangeAfterRange:(NSRange)aRange {
	return NSMakeRange(NSMaxRange(aRange), self.length - NSMaxRange(aRange));
}

-(NSRange) rangeFromEndOfRange:(NSRange)aRange {
	return NSMakeRange(NSMaxRange(aRange) - 1, self.length - NSMaxRange(aRange) + 1);
}

-(NSRange) rangeToEndFrom:(NSRange)aRange {
	return NSMakeRange(aRange.location, self.length - aRange.location);
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
