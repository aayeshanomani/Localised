import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService
{
  searchByName(String searchField)
  {
    return Firestore.instance.collection('locations')
    .where('type', isEqualTo: "merchant")
    .where('searchKey', isEqualTo: searchField.substring(0,1))
    .getDocuments();
  }

  searchUsername(String username)
  {
    dynamic check;
    check = Firestore.instance.collection('locations')
        .getDocuments();
    if(check != null)
      for(int i = 0; i<check.documents.length; i++)
        {
          if(check.documents[i].data['name'] == username)
            return false;
        }
    return true;
  }
}