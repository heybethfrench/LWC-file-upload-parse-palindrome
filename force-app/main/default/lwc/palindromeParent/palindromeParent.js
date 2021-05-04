import { LightningElement, track, wire } from 'lwc';
import parseFileBody from '@salesforce/apex/FileUploadHelper.parseFileBody';


export default class PalindromeParent extends LightningElement {
    @track documentId;
    @track documentBody;

    @wire(parseFileBody, {documentId: '$documentId'})
    wiredDocumentBody({data, error}){
        if(data){
            this.error = undefined;
            this.documentBody = data;

            console.log(JSON.parse(JSON.stringify(this.documentBody)));
            console.log(JSON.parse(JSON.stringify(this.documentBody[0]['palindrome'])));
            console.log(JSON.parse(JSON.stringify(this.documentBody[0]['abcAnalysis'])));
        } else if (error){
            console.log('theres an error');
            this.error = error;
            console.log(error);
            
            this.documentBody = undefined;
         

            
        }
    }
    

    handleDocIdEvent(event){
        console.log('event received');
        this.documentId = event?.detail && event?.detail?.value;   
        
    }

    }