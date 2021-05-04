public with sharing class FileUploadHelper {

    //retrieves the document body of the file that was uploaded, and returns a List of Data Wrappers -- one for each palindrome
    @AuraEnabled(cacheable=true)
    public static List<PalWrapper> parseFileBody(String documentId){
        
        ContentVersion myContent = [SELECT VersionData 
                                    FROM ContentVersion 
                                    WHERE ContentDocumentId = :documentId
                                    AND IsLatest = true LIMIT 1];

        List<String> docBody = myContent.VersionData.toString().split('\n');
        List<String> palindromes = new List<String>();
        List<PalWrapper> palWrapperList = new List<PalWrapper>(); 

        for(String s : docBody){ 
            //remove special characters, whitespace, and make all letters lower case
            //only returns strings that are palindromes
            if(isPalindrome(s)){
                palindromes.add(s);
            }     
        }

        
        for(String pal : palindromes){
            //creates data wrapper for letter counts
            List<abcWrapper> letterMap = createLetterMap(pal);

            //creates data wrapper for the palindrome
            PalWrapper tempWrap = new PalWrapper(pal, letterMap);

            palWrapperList.add(tempWrap);
            
        }   
            return palWrapperList;
    }

    //function that determines if a string is a palindrome
    public static Boolean isPalindrome(String s){
        String newString = s.replaceAll('[^a-zA-Z0-9\\s+]', '').toLowerCase().deleteWhitespace();
        String revString = newString.reverse();
        if(newString == revString){
            return true;
        } else {
            return false;
        }
    }

    //function that creates a Map of statistical data re: letter occurance in any given string
    public static List<abcWrapper> createLetterMap(String palindrome){
        List<abcWrapper> abcWrapList = new List<abcWrapper>();
        List<String> palCharList = palindrome.split('');
        String abc = 'abcdefghijklmnopqrstuvwxyz';
        List<String> abcList = abc.split('');
    
        Integer key = 0;
        
        for(String letter : abcList){
            Integer numOfTimes = 0;
            
            //compare the current loop letter from the abcList to the palindrome.  If the plaindrome contains that letter, count how many times that letter occurs within the palindrome
            if(palCharList.contains(letter)){
                for(String s: palCharList){
                    if(s == letter){
                        numOfTimes = numOfTimes + 1;
                    }
                }
            }
            
            //put the letter and the number of times it occurs in the palindrome in the abc wrapper
            abcWrapList.add(new abcWrapper(key, letter, numOfTimes));
            key = key + 1;
            
        }

        return abcWrapList;

    }

    public class PalWrapper {
		@AuraEnabled 
		public String palindrome {get;set;}
		@AuraEnabled
		public List<abcWrapper> abcAnalysis {get;set;}
     
		public PalWrapper(String thePalindrome, List<abcWrapper> theAbcAnalysis) {
            this.palindrome = thePalindrome;
            this.abcAnalysis = theAbcAnalysis;
            
		}
	} 

    public class abcWrapper{
        @AuraEnabled
        public Integer abcWrapId {get;set;}
        @AuraEnabled
        public String key {get;set;}
        @AuraEnabled
        public Integer value {get;set;}

        public abcWrapper(Integer theId, String theKey, Integer theValue){
            this.abcWrapId = theId;
            this.key = theKey;
            this.value = theValue;
        }
    }
}
