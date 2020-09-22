import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/error/exceptions.dart';
import '../models/comentario_model.dart';

abstract class ComentarioDataSource {
  /// Busca todos os comentários
  Future<List<ComentarioModel>> getComentarios();

  /// Salva um comentário
  Future<List<ComentarioModel>> setComentario({ComentarioModel comentario});

  /// Deleta um comentário
  Future<List<ComentarioModel>> delComentario({ComentarioModel comentario});
}

class ComentarioDataSourceImpl implements ComentarioDataSource {
  @override
  Future<List<ComentarioModel>> getComentarios() async {
    try {
      QuerySnapshot ref = await Firestore.instance
          .collection('comentarios')
          .orderBy('created_at', descending: true)
          .getDocuments();

//       Stream<QuerySnapshot> ref =
//           Firestore.instance.collection('comentarios').snapshots();
      List<ComentarioModel> _comentarioModel = [];
      ref.documents.forEach((doc) {
        _comentarioModel.add(ComentarioModel.fromJson(doc.data));
        _comentarioModel.last.reference = doc.reference;
      });
      // ref.documents.map(
      //     (doc) => _comentarioModel.add(ComentarioModel.fromJson(doc.data)));
      return _comentarioModel;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  // ignore: missing_return
  Future<List<ComentarioModel>> setComentario(
      {ComentarioModel comentario}) async {
    try {
      if (comentario.reference == null)
        comentario.reference =
            Firestore.instance.collection('comentarios').document();
      await comentario.reference.setData(comentario.toJson());

      return getComentarios();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<ComentarioModel>> delComentario(
      {ComentarioModel comentario}) async {
    try {
      if (comentario.reference != null) await comentario.reference.delete();

      return getComentarios();
    } catch (e) {
      throw ServerException();
    }
  }
}
