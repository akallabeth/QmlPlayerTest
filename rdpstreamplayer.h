#ifndef RDPSTREAMPLAYER_H
#define RDPSTREAMPLAYER_H

#include <QFile>
#include <QUrl>
#include <QMediaPlayer>
#include <QQmlParserStatus>

namespace com {
namespace thincast {

class RDPStreamPlayer : public QMediaPlayer
{
        Q_OBJECT
        Q_PROPERTY(QUrl source READ source WRITE setSource NOTIFY sourceChanged)
        Q_PROPERTY(QAbstractVideoSurface *videoSurface READ getVideoSurface WRITE
                   setVideoSurface )

    public:
        RDPStreamPlayer(QObject *parent = 0, Flags flags = 0);
        virtual ~RDPStreamPlayer() {}

        virtual QUrl source() const;
        virtual void setSource(const QUrl &url);

    public slots:
        virtual void setVideoSurface(QAbstractVideoSurface *surface);
        virtual QAbstractVideoSurface *getVideoSurface();

    signals:
        void sourceChanged();

    private:
        QAbstractVideoSurface *m_surface;
        QUrl m_source;
};
}
}
#endif // RDPSTREAMPLAYER_H
